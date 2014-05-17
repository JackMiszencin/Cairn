class AdminController < ApplicationController
	before_filter :authenticate_admin_user!

	def index
	end

  def after_sign_in_path_for(resource_or_scope)
  	return admin_root_path
  end


end