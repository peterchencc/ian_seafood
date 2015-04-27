class Product < ActiveRecord::Base

  validates_presence_of :name, :price, :in_stock_qty
  validates_numericality_of :in_stock_qty, :only_integer => true
  validates_numericality_of :price, :only_integer => true, :greater_than => 1

end
