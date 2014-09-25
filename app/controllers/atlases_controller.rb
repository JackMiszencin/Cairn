class AtlasesController < ApplicationController
	def edit
		get_organization
		get_atlas
		@tag_types = @organization.tag_types
		@tag = (@atlas.realm || Tag.new)
		@realm = @organization.realm
	end

	def show
		get_organization
		get_atlas
	end

	def set_realm
		realm = (@atlas.realm || Tag.new(:organization_id => @organization.id))
		ok = realm.update_attributes(tag_params) && 
			@atlas.update_attributes(:realm_id => realm.id)
		return ok
	end

	def update
		get_organization
		get_atlas
		realm_ok = (atlas_params[:geo_filter] && atlas_params[:geo_filter].to_s != '0') ? set_realm : true
		ok = realm_ok && @atlas.update_attributes(atlas_params)
		flash[:notice] = ok ? 'Updated atlas' : 'Failed to update'
		return redirect_to atlas_path(@organization.id, @atlas.id)
	end

	private

	def get_organization
		@organization = Organization.find(params[:organization_id])
		return render_404 unless @organization
	end

	def get_atlas
		@atlas = Atlas.find(params[:id])
		return render_404 unless @atlas
	end

	def atlas_params
		params.require(:atlas).permit(:name, :geo_filter, :realm_attributes => [:id])
	end

	def tag_params
		params.require(:tag).permit(:name, :center, :radius, :tag_type_id, :organization_id)
	end
end