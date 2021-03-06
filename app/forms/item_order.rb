class ItemOrder

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token, :user_id, :item_id

  with_options presence: true do
    validates :postal_code,   format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, length: { maximum: 11 }
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create!(user_id: user_id, item_id: item_id)
    Address.create!(postal_code: postal_code, prefecture_id:  prefecture_id, city: city, phone_number: phone_number,address: address, building_name: building_name, order_id: order.id)
  end
end