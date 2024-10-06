# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'csv'

# Clear existing data
Product.delete_all
Category.delete_all

csv_file_path = Rails.root.join('db', 'products.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
  # Find the category or create a new one
  category = Category.find_or_create_by(name: row['category'])

  # Create a new product
  Product.create!(
    title: row['name'],
    price: row['price'],
    description: row['description'],
    stock_quantity: row['stock quantity'],
    category: category
  )
end

puts "Products and categories imported successfully!"

