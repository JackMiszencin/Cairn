class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
  	return root_path
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

end
