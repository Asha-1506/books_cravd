class AddBooksCountToCategories < ActiveRecord::Migration[7.1]
  def up
    add_column :categories, :books_count, :integer, default: 0, null: false
    
    # Reset counter cache
    Category.find_each do |category|
      Category.reset_counters(category.id, :books)
    end
  end

  def down
    remove_column :categories, :books_count
  end
end
