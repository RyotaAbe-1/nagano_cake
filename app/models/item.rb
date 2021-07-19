class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  attachment :image

  def self.search(keyword)
    if keyword
      where("name LIKE? OR introduction LIKE?", "%#{keyword}%", "%#{keyword}%")
    end
  end

end
