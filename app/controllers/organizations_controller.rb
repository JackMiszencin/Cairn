class OrganizationsController < ApplicationController
	def show
		get_organization
		@atlases = @organization.atlases
	end

	def get_organization
		@organization = Organization.find(params[:id])
		return render_404 unless @organization
	end
end