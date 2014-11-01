class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, :if => :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.to_s == "admin_user"
      return admin_root_path
    else
      return root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.to_s == "admin_user"
      return admin_root_path
    else
      return root_path
    end
  end

  def render_404
  	respond_to do |format|
  		format.html { render template: 'errors/404.html', status: 404, layout: 'layouts/application.html.erb' }
  		format.all { render nothing: true, status: 404 }
  	end
  end

  def render_500
  	respond_to do |format|
  		format.html { render template: 'errors/500.html', status: 500, layout: 'layouts/application.html.erb' }
  		format.all { render nothing: true, status: 500 }
  	end
  end

  private

  def get_organization_for_user #IMPORTANT: uses organization_id param
    @organization = Organization.find(params[:organization_id])
    return render_404 unless @organization && current_user && current_user.is_org_user(@organization.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :organization_code
    devise_parameter_sanitizer.for(:sign_up) << :signup_organization_id
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end

end
