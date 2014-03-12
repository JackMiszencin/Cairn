require 'spec_helper'

feature 'user signs into home page' do
	scenario 'uses valid email and password' do
		visit root_path
		fill_in 'user_email', :with => "something@example.com"
		fill_in 'user_password', :with => "password"
		click_button 'Sign In'
		expect(page).to(have_css '.notice', :text => "Welcome to PlaceTags, something@example.com")
	end
end