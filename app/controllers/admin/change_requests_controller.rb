class Admin::ChangeRequestsController < AdminController
	before_filter :get_change_request

	def index
		@change_requests = ChangeRequest.unresolved
	end

	def edit
		unless @change_request
			return render_404
		end
	end

	def approve
		unless @change_request
			return render_500
		end
		@change_request.approve
		redirect_to admin_change_requests_path
	end

	def get_change_request
		@change_request = ChangeRequest.where(:id => params[:id]).last
	end
end