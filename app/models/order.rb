class Order < ActiveRecord::Base

  validates_presence_of :name
  has_many :line_items, :dependent => :destroy
  has_many :trades, :dependent => :destroy
  has_many :products, through: :line_items
  belongs_to :user

  def self.new_from_cart cart, params = {}
    order = self.new params
    order.line_items = cart.line_items
    order
  end

  def paid?
    trades.exists?(paid: true)
  end

  def total
    line_items.sum(:subtotal)
  end

end
