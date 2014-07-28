class PageController < ApplicationController
	def index
		@user = (current_user || User.new)
		if current_user && user_signed_in?
			flash[:notice] = "Welcome to PlaceTags, #{current_user.name}"
			@organization = @user.first_organization
			return render_404 unless @organization
		end
	end
end