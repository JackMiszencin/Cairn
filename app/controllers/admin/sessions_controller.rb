class Admin::SessionsController < Devise::SessionsController
	# GET /resource/sign_in
	def new
	    self.resource = resource_class.new(sign_in_params)
	    clean_up_passwords(resource)
	    respond_with(resource, serialize_options(resource))
	end

  def after_sign_in_path_for(resource_or_scope)
  	return admin_root_path
  end

end