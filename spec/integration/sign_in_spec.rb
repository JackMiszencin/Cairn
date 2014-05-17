require 'spec_helper'

feature 'user signs into home page' do
	scenario 'uses valid email and password' do
		visit root_path
		u = create(:user)
		fill_in 'user_email', :with => u.email
		fill_in 'user_password', :with => u.password
		click_button 'Sign In'
		expect(page).to(have_css 'h1', :text => "PlaceTags")
		expect(page).to(have_css '.notice', :text => "Welcome to PlaceTags, #{u.email}")
	end
end

feature 'admin user signs into admin scope root' do
	scenario 'uses valid email and password' do
		visit admin_root_path
		a = create(:admin_user)
		fill_in 'admin_user_email', :with => a.email
		fill_in 'admin_user_password', :with => a.password
		click_button 'Sign In'
		expect(page).to(have_css 'h1', :text => "Welcome to the admin module")
	end
end