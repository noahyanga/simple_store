class Product < ApplicationRecord

  validates :title, :price, :stock_quantity, presence: true
  validates :price, numericality: true
end
