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