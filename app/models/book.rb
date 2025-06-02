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

  def display_cover
    if cover.attached?
      Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true)
    else
      ActionController::Base.helpers.asset_path('default_book_cover.jpg')
    end
  end
end
