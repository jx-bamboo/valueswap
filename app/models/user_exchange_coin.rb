class UserExchangeCoin < ApplicationRecord
  belongs_to :user
  belongs_to :exchange
  belongs_to :coin

  validates :user_id, :exchange_id, :coin_id, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :user_id, uniqueness: { scope: [:exchange_id, :coin_id], message: "该交易所已绑定此币种" }
end
