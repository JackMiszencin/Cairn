class PageController < ApplicationController
	def index
		@user = (current_user || User.new)
		if current_user && user_signed_in?
			flash[:notice] = "Welcome to PlaceTags, #{current_user.email}"
			@organizations = @user.organizations
		end
	end
end