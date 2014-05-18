class Admin::ChangeRequestsController < AdminController
	def index
		@change_requests = ChangeRequest.unresolved
	end
end