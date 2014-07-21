class AdminController < ApplicationController
	before_filter :authenticate_admin_user!
	before_filter :set_admin_styles

	def index
	end

  def set_admin_styles
  	@admin_page = true
  end

end