# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# encoding: utf-8

require 'open-uri'

# Create categories
categories = {
  classic: Category.create!(name: 'Classic Literature', description: 'Timeless works that have influenced generations'),
  contemporary: Category.create!(name: 'Contemporary Fiction', description: 'Modern literary works from recent years'),
  nonfiction: Category.create!(name: 'Non-Fiction', description: 'Educational and informative works based on facts'),
  scifi: Category.create!(name: 'Science Fiction', description: 'Speculative fiction focusing on science and technology')
}

# Helper method to attach cover image
def attach_cover(book, url)
  return unless url
  begin
    file = URI.open(url)
    book.cover.attach(io: file, filename: "#{book.title.parameterize}.jpg")
  rescue => e
    puts "Failed to attach cover for #{book.title}: #{e.message}"
  end
end

# Sample books data
books_data = [
  # Classic Literature
  {
    category: categories[:classic],
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    description: 'A story of decadence and excess, Gatsby explores the American Dream in the 1920s.',
    published_year: 1925,
    isbn: '978-0743273565',
    cover_url: 'https://www.gutenberg.org/cache/epub/64317/pg64317.cover.medium.jpg'
  },
  {
    category: categories[:classic],
    title: '1984',
    author: 'George Orwell',
    description: 'A dystopian social science fiction novel and cautionary tale.',
    published_year: 1949,
    isbn: '978-0451524935',
    cover_url: 'https://www.gutenberg.org/cache/epub/67534/pg67534.cover.medium.jpg'
  },
  {
    category: categories[:classic],
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    description: 'A story of racial injustice and loss of innocence in the American South.',
    published_year: 1960,
    isbn: '978-0446310789',
    cover_url: 'https://upload.wikimedia.org/wikipedia/commons/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg'
  },
  {
    category: categories[:classic],
    title: 'The Hobbit',
    author: 'J.R.R. Tolkien',
    description: 'A fantasy novel about the adventures of Bilbo Baggins.',
    published_year: 1937,
    isbn: '978-0547928227',
    cover_url: 'https://www.gutenberg.org/cache/epub/19002/pg19002.cover.medium.jpg'
  },
  {
    category: categories[:classic],
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    description: 'A romantic novel of manners set in early 19th century England.',
    published_year: 1813,
    isbn: '978-0141439518',
    cover_url: 'https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg'
  },
  # Contemporary Fiction
  {
    category: categories[:contemporary],
    title: 'The Midnight Library',
    author: 'Matt Haig',
    description: 'A novel about all the lives you could have lived and finding hope in dark times.',
    published_year: 2020,
    isbn: '978-0525559474',
    cover_url: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1602190253i/52578297.jpg'
  },
  {
    category: categories[:contemporary],
    title: 'Project Hail Mary',
    author: 'Andy Weir',
    description: 'A lone astronaut must save humanity from extinction in this interstellar adventure.',
    published_year: 2021,
    isbn: '978-0593135204',
    cover_url: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1597695864i/54493401.jpg'
  },
  # Non-Fiction
  {
    category: categories[:nonfiction],
    title: 'Sapiens: A Brief History of Humankind',
    author: 'Yuval Noah Harari',
    description: 'A groundbreaking narrative of humanity\'s creation and evolution.',
    published_year: 2014,
    isbn: '978-0062316097',
    cover_url: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1595674533i/23692271.jpg'
  },
  {
    category: categories[:nonfiction],
    title: 'Atomic Habits',
    author: 'James Clear',
    description: 'An easy and proven way to build good habits and break bad ones.',
    published_year: 2018,
    isbn: '978-0735211292',
    cover_url: 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1655988385i/40121378.jpg'
  },
  # Science Fiction
  {
    category: categories[:scifi],
    title: 'Dune',
    author: 'Frank Herbert',
    description: 'A masterpiece of science fiction about politics, religion, and power on a desert planet.',
    published_year: 1965,
    isbn: '978-0441172719',
    cover_url: 'https://www.gutenberg.org/cache/epub/44942/pg44942.cover.medium.jpg'
  }
]

# Clear existing books
Book.destroy_all

# Create new books
books_data.each do |book_data|
  book = Book.create!(book_data.except(:cover_url))
  attach_cover(book, book_data[:cover_url])
  puts "Created book: #{book.title}"
end

puts "\nCreated #{Book.count} books!"
