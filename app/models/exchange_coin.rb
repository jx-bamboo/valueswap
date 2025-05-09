class ExchangeCoin < ApplicationRecord
  belongs_to :exchange
  belongs_to :coin

  validates :exchange_id, :coin_id, presence: true
  validates :exchange_id, uniqueness: { scope: :coin_id, message: "该交易所已支持此币种" }
end
