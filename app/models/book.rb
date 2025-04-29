class Book < ApplicationRecord
  belongs_to :category, counter_cache: true, optional: true
  belongs_to :user
  has_one_attached :cover

  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :published_year, presence: true, 
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Time.current.year }
  validates :isbn, uniqueness: true, allow_blank: true

  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }
  scope :uncategorized, -> { where(category_id: nil) }

  # Sorting scopes
  scope :by_title, ->(direction = :asc) { order(title: direction) }
  scope :by_author, ->(direction = :asc) { order(author: direction) }
  scope :by_year, ->(direction = :asc) { order(published_year: direction) }
  scope :sort_by_category, ->(direction = :asc) { 
    left_joins(:category)
      .order(Arel.sql("COALESCE(categories.name, '') #{direction == :asc ? 'ASC' : 'DESC'}"))
  }

  def self.sorted(field = 'title', direction = 'asc')
    direction = direction.to_sym
    case field
    when 'title'
      by_title(direction)
    when 'author'
      by_author(direction)
    when 'year'
      by_year(direction)
    when 'category'
      sort_by_category(direction)
    else
      by_title(direction)
    end
  end

  def cover_url
    return cover if cover.attached?
    'https://placehold.co/200x300/lightgray/darkgray?text=No+Cover'
  end
end
