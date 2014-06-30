class OrganizationsController < ApplicationController
	def show
		get_organization
		@atlases = Atlas.where(:organization_id => @organization.id)
	end

	def get_organization
		@organization = Organization.find(params[:id])
		return render_404 unless @organization
	end
end