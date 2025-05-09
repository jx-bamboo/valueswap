class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
				 :confirmable, :lockable, :timeoutable, :trackable
				 
	has_many :user_exchanges, dependent: :destroy
	has_many :exchanges, through: :user_exchanges
	has_many :user_exchange_coins, through: :user_exchanges
	has_many :coins, through: :user_exchange_coins
	has_many :exchange_balances, dependent: :destroy
	has_many :invitations, dependent: :destroy
	has_one :user_address, dependent: :destroy
	
	# enum :role, {user: 0, vip: 1, admin: 2, super_admin: 3}
	enum :role, %w(user vip admin super_admin)
	
	scope :all_users, -> {all}
	scope :super_admin_count, -> {where(role: 3).count}
	scope :admin_count, -> {where(role: 2).count}
	scope :vip_count, -> {where(role: 1).count}
	scope :user_count, -> {where(role: 0).count}

	scope :group_by_role, -> {group(:role).count}
	

	# 验证邀请码的唯一性
	validates :invite_code, uniqueness: true, allow_nil: true

	
	# after_validation :check_invite_code, on: :create

	# 在创建用户之前生成邀请码
	before_validation :generate_invite_code, on: :create

	

	private

	# def check_invite_code
	# 	p self.invite_code, '. . . '
  #   if self.invite_code.present?
  #     inviter_user = User.find_by(invite_code: self.invite_code)
	# 		p inviter_user, '.. .. ..'


  #     if inviter_user.nil?
  #       errors.add :invite_code, "无效的邀请码"
  #     else
  #       inviter_user.invitations.create(invitee_id: self.id)
  #     end
  #   end
	# 	self.invite_code = SecureRandom.alphanumeric(6).upcase

	# end


	def generate_invite_code
		# return if invite_code.present?  # 如果已有邀请码则不生成
		
		loop do
			# 生成随机6位邀请码（可以根据需求调整长度和格式）
			self.invite_code = SecureRandom.alphanumeric(6).upcase
			break unless User.exists?(invite_code: invite_code)
		end
	end

end
