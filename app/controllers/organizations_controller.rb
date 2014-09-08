class OrganizationsController < ApplicationController
	def show
		get_organization
		@atlases = Atlas.where(:organization_id => @organization.id)
	end

	def get_organization
		@organization = Organization.find(params[:id])
		return render_404 unless @organization
	end

	def set_realm
		get_organization
		realm = Tag.new(:organization_id => @organization.id)
		ok = realm.update_attributes(params[:realm])
		flash[:notice] = ok ? 'Organization updated' : 'Failed to update. Please check your info and try again.'
		return redirect_to organization_path(@organization.id)
	end
end