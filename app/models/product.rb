class Product < ActiveRecord::Base

  has_many :packets, :dependent => :destroy
  has_many :line_items

  belongs_to :user

  validates_presence_of :name, :price, :in_stock_qty
  validates_numericality_of :in_stock_qty, :only_integer => true
  validates_numericality_of :price, :only_integer => true, :greater_than => 1

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
