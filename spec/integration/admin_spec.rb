require 'spec_helper'

feature 'admin tag change manager' do
	before(:each) do
		admin_sign_in
		create_change_request
	end
	scenario 'admin_user approves change' do
		@change_request.update_attributes(:lonlat => 'POINT(-122 47)')
		click_link('Manage Change Requests')
		click_link('Edit')
		click_button('Approve Change Request')
		expect(expect(page).to(have_css 'h1#index-title', :text => "Change Requests"))
		expect(@change_request.tag.center.x).to eq -122
	end
end

def admin_sign_in
	visit admin_root_path
	@admin_user = create(:admin_user)
	fill_in 'admin_user_email', :with => @admin_user.email
	fill_in 'admin_user_password', :with => @admin_user.password
	click_button 'Sign In'
end

def create_change_request
	@change_request = create(:change_request)
	t = create(:tag)
	u = create(:user)
	@change_request.update_attributes(:tag_id => t.id, :user_id => u.id)
	@change_request.save
end