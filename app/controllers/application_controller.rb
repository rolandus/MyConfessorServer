class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #skip_before_filter :verify_authenticity_token  #rscott - skip CSRF token check TODO: Figure out how to reenable this in tandem with Ajax.

  #layout :set_layout 
  before_action :set_namespace 
  rescue_from ActionController::RedirectBackError, :with => :go_home
  
  # After signing in, decide whether to redirect to the priest page or the admin page. 
  def after_sign_in_path_for(resource)
    if current_user_account.is_confessor?
      return priest_url
    else
      return admin_url
    end
    #rscott - This somehow makes Backbone think that login succeeded vs. failed. They both return a 302, though. This one just makes it redirect to the user you logged in as. I don't get it.
    #user_account_url(resource, :format => :json)
  end

  # After signing out, redirect to the sign in page.
  def after_sign_out_path_for(resource)
    new_user_account_session_url
  end

  ############
  # Utility functions to be used as before filters.
  ############
  
  def restrict_to_admin
    if not user_account_signed_in? or not current_user_account.is_admin? #current_user_account.account_role_ids.min <= 2
      respond_to do |format|
        format.html { render text: 'Find a way to redirect to login.', status: 401 }
        format.json { render text: '{ error: "401 Unauthorized access" }', status: 401 }
      end
    end 
  end
  
  def restrict_to_superuser
    if not user_account_signed_in? or not current_user_account.is_superadmin? #current_user_account.account_role_ids.include? 1
      respond_to do |format|
        format.html { render text: 'Find a way to redirect to login.', status: 401 }
        format.json { render text: '{ error: "401 Unauthorized access" }', status: 401 }
      end
    end 
  end
  
  ############
  # Utilities used by subclasses
  ############
  
  def go_home
    if @namespace == "admin"
      redirect_to admin_path
    elsif @namespace == "priest"
      redirect_to priest_path
    else
      redirect_to root_path
    end
  end
  
  def save_confessor_history (confessor, comments)
    confessor_change = ConfessorChange.new({
      # Make a copy of the current Confessor
      :confessor_id => confessor.id,
      :user_account_id => confessor.user_account_id,
      :confessor_office_id => confessor.confessor_office_id,
      :diocese_id => confessor.diocese_id,
      :salutation => confessor.salutation,
      :biography => confessor.biography,
      # Add change information and save it
      :change_comments => comments,
      :changed_by_user_account_id => current_user_account.id
    })
    confessor_change.save()
  end
  
  def save_user_account_history (user_account, comments)
      user_account_change = UserAccountChange.new({
        # Copy the user_account information
        :first_name => user_account.first_name,
        :last_name => user_account.last_name,
        :account_status_id => user_account.account_status_id,
        :home_phone => user_account.home_phone,
        :work_phone => user_account.work_phone,
        :mobile_phone => user_account.mobile_phone,
        :user_account_id => user_account.id,
        :email => user_account.email,
        # Add audit information
        :change_comments => comments,
        :changed_by_user_account_id => current_user_account.id
      })
      user_account_change.save()
  end

  # Allowed params for confessor create/update (shared by both confessor and user_account controllers)
  def confessor_params
    params.require(:confessor).permit(
      :confessor_office_id, 
      :diocese_id, 
      :salutation, 
      :biography, 
      :confession_status_id, 
      :confession_location_id, 
      :confession_start_time, 
      :confession_end_time, 
      :confession_comments
    )
  end

private

  # Set the correct layout
  #def set_layout
  #  user_account_signed_in? ? "user" : "penitent"
  #end
  
  def set_namespace
    @namespace = request.fullpath.split("/")[1]
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
