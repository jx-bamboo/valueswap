# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
	layout "admin_sign"
	
  # GET /resource/sign_up
  def new
    @invite_code = params[:invite_code] if params[:invite_code].present?
    super
  end

  # POST /resource
  def create
    super
  end
  # def create
  #   # 构建新用户
  #   build_resource(sign_up_params)

  #   # 如果有邀请码，验证其有效性
  #   # inviter = nil
  #   if sign_up_params[:invite_code].present?
  #     inviter = User.find_by(invite_code: sign_up_params[:invite_code])
  #     p inviter, '.. .当前邀请码是否有效. ..'

  #     if inviter.present?
  #       p '.. .. 邀请码有效 .. ..'
  #       ui = Invitation.new(
  #         user_id: inviter.id, # 邀请人
  #         invitee_id: resource.id, # 被邀请人
  #         invitation_code: inviter.invite_code, # 邀请码
  #         status: 0 # 默认状态
  #       )
  #       p ui, '.... 邀请记录是否创建成功 ....'
  #     else
  #       p '.. .. 邀请码无效 .. ..'
  #       resource.errors.add(:invite_code, '無效，請檢查後重試。')
  #       return render :new, status: :unprocessable_entity
  #     end
  #   end

  #   # 使用事务确保用户创建和邀请记录创建的原子性
  #   resource.save
  #   ui.save
  #   # ActiveRecord::Base.transaction do
  #   #   # 保存用户
  #   #   resource.save
      
  #   #   # 如果有邀请人，创建邀请记录
  #   #   # if inviter
  #   #   #   Invitation.create!(
  #   #   #     user_id: inviter.id, # 邀请人
  #   #   #     invitee_id: resource.id, # 被邀请人
  #   #   #     invitation_code: inviter.invite_code, # 邀请码
  #   #   #     status: 0 # 默认状态
  #   #   #   )
  #   #   # end
  #   #   ui.save
  #   #   p ui, '.... 邀请记录是否创建成功 ....'
      
  #   # end

  #   # 注册成功后的逻辑
  #   if resource.persisted?
  #     if resource.active_for_authentication?
  #       set_flash_message! :notice, :signed_up
  #       sign_up(resource_name, resource)
  #       respond_with resource, location: after_sign_up_path_for(resource)
  #     else
  #       set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
  #       expire_data_after_sign_in!
  #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # rescue ActiveRecord::RecordInvalid
  #   # 事务失败，回滚并显示错误
  #   clean_up_passwords resource
  #   set_minimum_password_length
  #   render :new, status: :unprocessable_entity
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:invite_code])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
