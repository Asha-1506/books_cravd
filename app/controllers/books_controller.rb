class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @categories = Category.all
    @current_category = Category.find_by(id: params[:category_id])
    @sort_field = params[:sort] || 'title'
    @sort_direction = params[:direction] || 'asc'
    
    @books = if params[:all] == 'true'
               Book.all
             else
               current_user.books
             end
    
    @books = @books.by_category(@current_category.id) if @current_category
    @books = @books.sorted(@sort_field, @sort_direction)
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.build
  end

  # GET /books/1/edit
  def edit
    unless admin_or_owner?(@book)
      flash[:alert] = "You are not authorized to edit this book"
      redirect_to books_path(view_mode: params[:view_mode]) and return
    end
  end

  # POST /books or /books.json
  def create
    @book = current_user.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    unless admin_or_owner?(@book)
      return head :forbidden
    end

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_path(view_mode: params[:view_mode]), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    unless admin_or_owner?(@book)
      flash[:alert] = "You are not authorized to delete this book"
      redirect_to books_path(view_mode: params[:view_mode]) and return
    end
    
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_path(view_mode: params[:view_mode]), notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def admin_or_owner?(book)
      current_user.admin? || book.user == current_user
    end

    def book_params
      params.require(:book).permit(:title, :author, :description, :published_year, :isbn, :category_id, :cover)
    end
end
