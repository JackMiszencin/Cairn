class PageController < ApplicationController
	def index
		@user = (current_user || User.new)
		if current_user && user_signed_in?
			flash[:notice] = "Welcome to PlaceTags, #{current_user.name}"
			@organization = @user.first_organization
			@tag_types = @organization.tag_types
			unless @organization.realm
				@new_realm = Tag.new(:organization_id => @organization.id.to_s)
			end
			return render_404 unless @organization
		end
	end
end