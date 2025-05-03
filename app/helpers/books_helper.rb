module BooksHelper
  def sort_indicator(field)
    return '' unless params[:sort] == field
    params[:direction] == 'desc' ? '▼' : '▲'
  end

  def next_sort_direction(field)
    if params[:sort] == field && params[:direction] == 'asc'
      'desc'
    else
      'asc'
    end
  end

  def admin_or_owner?(book)
    current_user.admin? || book.user == current_user
  end

  def sort_link(field, title = nil)
    title ||= field.to_s.titleize
    link_to books_path(
      sort: field, 
      direction: next_sort_direction(field), 
      category_id: params[:category_id],
      all: params[:all],
      view_mode: params[:view_mode]
    ), class: 'dropdown-item' do
      "#{title} #{sort_indicator(field)}"
    end
  end
end
