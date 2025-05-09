class Admin::UserController < ApplicationController
	before_action :authenticate_user!
	layout "admin"
	
  def index
	  @all_users = User.all_users
  end
end
