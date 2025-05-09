class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :user_exchange
  belongs_to :coin
	
	# enum trade_type: [manual, quant, ai]
	# enum action: [buy, sell]
	# enum status: [pending, completed, canceled]

	validates :trade_type, inclusion: { in: %w[manual quant ai] }
  validates :side, inclusion: { in: %w[buy sell] }
  validates :order_type, inclusion: { in: %w[limit market] }
  validates :status, inclusion: { in: %w[pending filled cancelled failed] }
  validates :price, :quantity, numericality: { greater_than: 0 }
  validates :fee, :profit_loss, numericality: true, allow_nil: true
  validates :leverage, numericality: { greater_than_or_equal_to: 1 }, allow_nil: true
  validates :position_side, inclusion: { in: %w[long short] }, allow_nil: true
  validates :order_id, presence: true, uniqueness: true
  validates :executed_at, presence: true
  validates :user_id, :exchange_id, :user_exchange_id, :coin_id, presence: true
end
