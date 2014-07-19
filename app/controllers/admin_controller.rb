class AdminController < ApplicationController
	before_filter :authenticate_admin_user!
	before_filter :set_admin_styles

	def index
	end

  def after_sign_in_path_for(resource_or_scope)
  	return admin_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    return admin_root_path
  end


  def set_admin_styles
  	@admin_page = true
  end

end