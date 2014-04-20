class PageController < ApplicationController
	def index
		@user ||= User.new
		flash[:notice] = "Welcome to PlaceTags, #{current_user.email}" if current_user && user_signed_in?
	end
end