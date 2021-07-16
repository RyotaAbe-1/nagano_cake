class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum product_status: {
    "制作不可": 0,
    "制作待ち": 1,
    "制作中": 2,
    "制作完了": 3
  }

  def include_tax(tax)
    item.price * tax
  end
end
