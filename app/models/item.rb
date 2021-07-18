class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :image_id, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

  attachment :image


end
