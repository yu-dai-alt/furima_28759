class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_users
  has_many :users, through: :item_users
  has_one_attached :image

  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :item_status
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :delivery_fee

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40,
      too_long: "最大%{count}文字まで使えます" }
    validates :info, length: { maximum: 1000,
      too_long: "最大%{count}文字まで使えます" }
    validates :category_id
    validates :item_status_id
    validates :shipping_day_id
    validates :prefecture_id
    validates :delivery_fee_id
    validates :price, format: {with: /\A[0-9]+\z/, message: "は半角数字で入力してください"}
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_ot_equal_to: 9_999_999 }
  end
end
