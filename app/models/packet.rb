class Packet < ActiveRecord::Base
  validates_presence_of :title, :product_id
  belongs_to :product

  has_many :pictures, :as => :imageable

  accepts_nested_attributes_for :pictures, allow_destroy: true, :reject_if => :all_blank

  def final_price
    self.price + self.product.price    
  end
end
