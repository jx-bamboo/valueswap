class Coin < ApplicationRecord
  has_many :user_exchange_coins, dependent: :destroy
  has_many :exchanges_coins
  has_many :exchanges, through: :exchange_coins

  has_one_attached :logo

  before_save :upcase_symbol_quote_coin, :downcase_name
  private

  def upcase_symbol_quote_coin
    self.symbol = symbol.upcase if symbol.present?
    self.quote_coin = quote_coin.upcase if quote_coin.present?
  end

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
