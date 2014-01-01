class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token  #rscott - skip CSRF token check TODO: Figure out how to reenable this in tandem with Ajax.

  def after_sign_in_path_for(resource)
    #rscott - This somehow makes Backbone think that login succeeded vs. failed. They both return a 302, though. This one just makes it redirect to the user you logged in as. I don't get it.
    user_account_url(resource, :format => :json)
  end

  def restrict_to_admin
    if not user_account_signed_in? or not current_user_account.account_role_ids.min <= 2
      render text: '{ error: "401 Unauthorized access" }', status: 401
    end 
  end
  
  def restrict_to_superuser
    if not user_account_signed_in? or not current_user_account.account_role_ids.include? 1
      render text: '{ error: "401 Unauthorized access" }', status: 401
    end 
  end

=begin
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
 
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
=end

end
