class PageController < ApplicationController
	def index
		@user = User.new
	end
end