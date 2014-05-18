require 'spec_helper'

feature 'admin tag change manager' do
	before(:each) do
		admin_sign_in
		create_change_request
	end
	scenario 'admin_user approves change' do
		click_link('Manage Change Requests')
		click_link('.change-request .view')
		click_button('.approve')
		expect(@tag.radius).to eq 5
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

end