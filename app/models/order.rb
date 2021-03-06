class Order < ApplicationRecord
	# 注文詳細との紐付け
	has_many :ordered_items, dependent: :destroy
	has_many :products, through: :ordered_items
	accepts_nested_attributes_for :ordered_items
	# 顧客との紐付け
	belongs_to :user

	scope :created_today, -> { where(created_at: Time.zone.now.all_day) }

	#enum_支払い方法
	enum payment: {クレジットカード:1, 銀行振込:2}

	#注文ステータス
	enum deposit_status: {入金待ち:1,発送待ち:2,発送済み:3}


    validates :last_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}, presence: true
    validates :first_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}, presence: true
    validates :ship_postal_code, format: /\A[0-9]+\z/, presence: true#郵便番号数字のみ
    validates :last_name, presence: true
    validates :first_name, presence: true
end