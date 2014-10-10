class OrganizationsController < ApplicationController
	def show
		get_organization
		@atlases = Atlas.where(:organization_id => @organization.id)
	end

	def set_realm
		get_organization
		realm = Tag.new(:organization_id => @organization.id, :name => @organization.name)
		ok = realm.update_attributes(tag_params) && 
			@organization.update_attributes(:realm_id => realm.id)
		flash[:notice] = ok ? 'Organization updated' : 'Failed to update. Please check your info and try again.'
		return redirect_to organization_path(@organization.id)
	end

	private

	def get_organization
		@organization = Organization.find(params[:id])
		return render_404 unless @organization
	end

	def tag_params
		params.require(:tag).permit(:name, :center, :radius, :tag_type_id, :organization_id)
	end
end