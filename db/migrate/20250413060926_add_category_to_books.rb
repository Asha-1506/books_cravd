class AddCategoryToBooks < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :category, null: true, foreign_key: true
  end
end
