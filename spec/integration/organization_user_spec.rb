require 'spec_helper'

@organization_name = 'my org'
@organization_name2 = 'his org'
@atlas_name = 'my atlas'
@atlas_name2 = 'his atlas'

feature 'user can see all atlases belonging to organization' do
	before(:each) do
		sign_in
	end

	scenario 'user can see organizations they belong to' do
		expect(page).to(have_css 'a.organization_name', :text => @organization_name)
	end

	scenario 'user can see atlases belonging to organization' do
		expect(page).to(have_css 'a.organization_name', :text => @organization_name)
		visit organization_path(@organization.id)
		create_atlas
		org2 = create(:organization, :name => @organization_name2)
		atlas2 = create(:atlas, :organization_id => org2.id, :name => @atlas_name2)
		expect(page).to(have_css '.atlas', :text => @atlas.name)
		expect(page).to_not(have_css '.atlas', :text => @atlas_name2)
	end
end

def sign_in
	visit root_path
	create_org_user
	fill_in 'user_email', :with => @user.email
	fill_in 'user_password', :with => @user.password
	click_button 'Sign In'
end

def create_org_user
	@user = create(:user)
	@organization = create(:organization, :name => @organization_name)
	create(:organization_user,
		:user_id => @user.id, 
		:organization_id => @organization.id, 
		:manager => false)
end

def create_atlas(attrs={})
	@atlas = create(:atlas, :organization_id => (@organization ? @organization.id : nil), :name => @atlas_name)
	@atlas.update_attributes(attrs)
	return @atlas
end
