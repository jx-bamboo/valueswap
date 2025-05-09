class Fund < ApplicationRecord
  belongs_to :user

  has_one_attached :logo

  scope :home_funds, -> { order(created_at: :desc).limit(5) }
end
