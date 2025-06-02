# Clean up existing data
Book.destroy_all
Category.destroy_all
User.destroy_all

# Create admin user
admin = User.create!(
  email: 'admin@example.com',
  password: ENV.fetch('ADMIN_PASSWORD', 'password123'),
  admin: true
)
puts "Created admin user: #{admin.email}"

# Create categories
categories = {
  fiction: Category.create!(name: 'Fiction'),
  nonfiction: Category.create!(name: 'Non-Fiction'),
  scifi: Category.create!(name: 'Science Fiction'),
  fantasy: Category.create!(name: 'Fantasy')
}
puts "Created categories: #{categories.values.map(&:name).join(', ')}"

# Books data
books_data = [
  {
    title: "1984",
    author: "George Orwell",
    description: "A dystopian novel set in a totalitarian society",
    published_year: 1949,
    isbn: "978-0451524935",
    category: categories[:scifi]
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    description: "A story of racial injustice and the loss of innocence in the American South",
    published_year: 1960,
    isbn: "978-0446310789",
    category: categories[:fiction]
  },
  {
    title: "A Brief History of Time",
    author: "Stephen Hawking",
    description: "A landmark volume in science writing by one of the great minds of our time",
    published_year: 1988,
    isbn: "978-0553380163",
    category: categories[:nonfiction]
  },
  {
    title: "The Lord of the Rings",
    author: "J.R.R. Tolkien",
    description: "An epic high-fantasy novel that follows the quest to destroy a powerful ring.",
    published_year: 1954,
    isbn: "978-0618640157",
    category: categories[:fantasy]
  },
  {
    title: "Dune",
    author: "Frank Herbert",
    description: "A science fiction masterpiece about politics, religion, and ecology on a desert planet.",
    published_year: 1965,
    isbn: "978-0441172719",
    category: categories[:scifi]
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    description: "A romantic novel of manners about prejudice and marriage in Georgian England.",
    published_year: 1813,
    isbn: "978-0141439518",
    category: categories[:fiction]
  },
  {
    title: "The Origin of Species",
    author: "Charles Darwin",
    description: "A groundbreaking work on evolutionary biology and natural selection.",
    published_year: 1859,
    isbn: "978-0486450063",
    category: categories[:nonfiction]
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    description: "A fantasy novel about the adventures of Bilbo Baggins.",
    published_year: 1937,
    isbn: "978-0547928227",
    category: categories[:fantasy]
  }
]

# Create books and attach covers
books_data.each do |book_data|
  book = admin.books.create!(book_data)
  puts "Created book: #{book.title}"
  
  # Attach cover from Open Library
  require 'open-uri'
  begin
    isbn = book_data[:isbn].gsub('-', '')
    cover_url = "https://covers.openlibrary.org/b/isbn/#{isbn}-L.jpg"
    file = URI.open(cover_url)
    
    book.cover.attach(
      io: file,
      filename: "#{book.title.parameterize}.jpg",
      content_type: 'image/jpeg'
    )
    puts "Attached cover for: #{book.title}"
  rescue => e
    puts "Error attaching cover for #{book.title}: #{e.message}"
    # Try placeholder as fallback
    begin
      placeholder_url = "https://placehold.co/400x600/lightgray/darkgray?text=#{CGI.escape(book.title)}"
      file = URI.open(placeholder_url)
      book.cover.attach(
        io: file,
        filename: "#{book.title.parameterize}.jpg",
        content_type: 'image/jpeg'
      )
      puts "Attached placeholder for: #{book.title}"
    rescue => e
      puts "Failed to attach placeholder for #{book.title}: #{e.message}"
    end
  end
end

puts "\nSeeding completed!"
puts "Created #{Category.count} categories"
puts "Created #{Book.count} books"
