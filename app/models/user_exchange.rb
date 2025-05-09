class UserExchange < ApplicationRecord
  belongs_to :user
  belongs_to :exchange
  has_many :exchange_balances

  validates :api_key, presence: true, uniqueness: true
  validates :api_secret, presence: true, uniqueness: true
end
