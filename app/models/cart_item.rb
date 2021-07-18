class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def include_tax(tax)
    item.price * tax
  end
end
