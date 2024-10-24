# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require 'faker'

# 676.times do
#   Product.create!(
#     title: Faker::Commerce.product_name,
#     price: Faker::Commerce.price(range: 0.1..100.0),
#     stock_quantity: Faker::Number.between(from: 1, to: 100)
#   )
# end

# puts "Seeded 676 products"

require 'csv'

# Product.destroy_all
# Category.destroy_all

csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')


products.each do |product_row|
  category_name = product_row['category']
  
  category = Category.find_or_create_by!(name: category_name)

  Product.create!(
    title: product_row['name'], 
    price: product_row['price'].to_f,
    description: product_row['description'], 
    stock_quantity: product_row['stock quantity'].to_i,
    category: category 
  )
end

puts "#{Product.count} products created"
