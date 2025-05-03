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

  def cover_url
    return cover if cover.attached?
    'https://placehold.co/200x300/lightgray/darkgray?text=No+Cover'
  end
end
