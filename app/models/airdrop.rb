class Airdrop < ApplicationRecord
  belongs_to :user
  has_one_attached :logo

  scope :home_airdrops, -> {order(created_at: :desc).limit(5) }

end
