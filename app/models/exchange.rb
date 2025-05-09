class Exchange < ApplicationRecord
  has_many :user_exchanges, dependent: :destroy
  has_many :users, through: :user_exchanges
  has_many :exchange_coins
  has_many :coins, through: :exchange_coins

  has_one_attached :logo

  scope :exchange_count, -> { count }

  before_save :downcase_name
  private

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
