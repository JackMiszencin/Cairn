class AtlasesController < ApplicationController
	def edit
		get_organization
		get_atlas
		@tag_types = @organization.tag_types
		@tag = (@atlas.realm || Tag.new)
		@realm = @organization.realm
	end

	def set_realm
		get_organization
		get_atlas
		realm = Tag.new(:organization_id => @organization.id)
		ok = realm.update_attributes(tag_params) && 
			@atlas.update_attributes(:realm_id => realm.id)
		flash[:notice] = ok ? 'Atlas updated' : 'Failed to update. Please check your info and try again.'
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

	def tag_params
		params.require(:tag).permit(:name, :center, :radius, :tag_type_id)
	end
end