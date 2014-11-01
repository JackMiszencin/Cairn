class AtlasesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :get_organization_for_user

	def edit
		get_atlas
		@tag_types = @organization.tag_types
		@tag = (@atlas.realm || Tag.new)
		@realm = @organization.realm
	end

	def new
		@atlas = Atlas.new(:organization_id => @organization.id)
		@tag_types = @organization.tag_types
		@tag = Tag.new
		@realm = @organization.realm
	end

	def show
		get_atlas
	end

	def set_realm
		realm = (@atlas.realm || Tag.new(:organization_id => @organization.id))
		realm_attrs = tag_params.merge({:name => @atlas.name})
		ok = realm.update_attributes(realm_attrs) && 
			@atlas.update_attributes(:realm_id => realm.id)
		return ok
	end

	def update
		get_atlas
		realm_ok = (atlas_params[:geo_filter] && atlas_params[:geo_filter].to_s != '0') ? set_realm : true
		ok = realm_ok && @atlas.update_attributes(atlas_params)
		flash[:notice] = ok ? 'Updated atlas' : 'Failed to update'
		return redirect_to atlas_path(@organization.id, @atlas.id)
	end

	def create
		@atlas = Atlas.new(:organization_id => @organization.id)
		realm_ok = nil
		atlas_ok = @atlas.update_attributes(atlas_params)
		if atlas_ok
			realm_ok = (atlas_params[:geo_filter] && atlas_params[:geo_filter].to_s != '0') ? set_realm : true
		end
		if atlas_ok && realm_ok
			flash[:notice] = 'Successfully created atlas'
			return redirect_to organization_path(@organization.id)
		else
			flash[:notice] = 'Failed to create atlas'
			return redirect_to new_atlas_path(@organization.id) 
		end
	end

	private

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