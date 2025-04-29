class Category < ApplicationRecord
  has_many :books, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  def self.with_books_count
    left_joins(:books)
      .select('categories.*, COUNT(books.id) as books_count')
      .group('categories.id')
  end
end
