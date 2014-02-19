class ConfessorRequestsController < ApplicationController
  before_action :set_confessor_request, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user_account!, except: [:new, :create]
  before_filter :restrict_to_admin, except: [:new, :create]
  
  layout "admin_inside"
    
  # GET /confessor_requests
  # GET /confessor_requests.json
  def index
    @filter = params[:filter]
    @filter = "pending" if !@filter
    case @filter
    when "pending"
      @confessor_requests = ConfessorRequest.where(confessor_request_status_id: 2)
    when "new"
      @confessor_requests = ConfessorRequest.where(confessor_request_status_id: 1)
    end
  end

  # GET /confessor_requests/1
  # GET /confessor_requests/1.json
  def show
    @is_approval = true
  end

  # GET /confessor_requests/new
  def new
    if params[:status] == "submitted"
      @confessor_request = ConfessorRequest.find(params[:id])
      render "confirm"
    else
      @confessor_request = ConfessorRequest.new
      render layout: "application"
    end
  end
  
  # GET /confessor_requests/1/edit
  #def edit
  #end

  # POST /confessor_requests
  # POST /confessor_requests.json
  def create
    @confessor_request = ConfessorRequest.new(confessor_request_create_params)
    @confessor_request.confessor_request_status_id = 1 #Set the status to 1-Created.
    @confessor_request.confirmation_number = SecureRandom.hex[0, 8]
    
    respond_to do |format|
      if @confessor_request.save
        save_to_history
        format.html { redirect_to new_confessor_request_path(:status => "submitted", :id => @confessor_request.id) }        
        #format.json { render action: 'show', status: :created, location: @confessor_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @confessor_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confessor_requests/1
  # PATCH/PUT /confessor_requests/1.json
  def update
      
    # Hacky way to get status from the submit button, rather than a radio button
    # TODO Is there a better way?
    case params[:commit]
    when "Pend"
      if @confessor_request.is_created?
        @confessor_request.pend 
        @confessor_request.user_account_id = current_user_account.id
      end
    when "Approve"        
      @confessor_request.approve
    when "Deny"
      @confessor_request.deny if @confessor_request.is_created? or @confessor_request.is_pending?
    when "Drop" 
      # Means this user isn't handling this request anymore.
      if @confessor_request.is_pending?
        @confessor_request.set_created
        @confessor_request.user_account_id = ""
      end
    end
    
    respond_to do |format|      
      if @confessor_request.update(confessor_request_update_params) and save_to_history
        
        # If the request is newly approved, create a new user account with the stub information.
        is_user_account_created = false
        if @confessor_request.confessor_request_status_id_changed? and @confessor_request.is_approved?
          errors = create_new_confessor
          if !@new_user_account
            render json: @confessor_request.errors, status: :unprocessable_entity
            return
          end
        end
        
        # Redirect to the appropriate place based on what status was set.
        format.html { 
          case params[:commit]
          when "Pend", "Deny", "Drop"
            redirect_to confessor_requests_path
          when "Approve"        
            if @new_user_account
              redirect_to @new_user_account
            else
              redirect_to confessor_requests_path
            end
          end          
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confessor_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessor_request
      @confessor_request = ConfessorRequest.find(params[:id])
    end
    
    # Create a new stub confessor based on this confessor request.
    def create_new_confessor
      @new_user_account = UserAccount.new(
        #first_name: "Johnny",
        #last_name: "Jolly",
        #account_status_id: 1, # Create as inactive at first.
        #username: @confessor_request.email,
        #password: "confessor"
      )
      @new_user_account.save
      return @new_user_account.errors
=begin
      return false if !save_user_account_history(@new_user_account, "Created")
      
      @new_confessor = Confessor.create(
        confessor_office_id: 1, 
        diocese_id: @confessor_request.diocese, 
        user_account_id: @new_user_account.id, 
        confession_status: 3
      )
      return false if !save_confessor_history(@new_confessor, "Created")
      
      return true
=end
    end

    def save_to_history
      # Copy confessor requests properties
      confessor_request_change = ConfessorRequestChange.new
      confessor_request_change.first_name = @confessor_request.first_name
      confessor_request_change.last_name = @confessor_request.last_name
      confessor_request_change.email = @confessor_request.email
      confessor_request_change.diocese_id = @confessor_request.diocese_id
      confessor_request_change.confessor_request_status_id = @confessor_request.confessor_request_status_id
      confessor_request_change.user_account_id = @confessor_request.user_account_id
      confessor_request_change.comments = @confessor_request.comments
      # Add audit trail properties
      confessor_request_change.confessor_request_id = @confessor_request.id
      confessor_request_change.changed_by_user_account_id = current_user_account ? current_user_account.id : 1
      confessor_request_change.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_request_create_params
      params.require(:confessor_request).permit(:first_name, :last_name, :email, :diocese_id, :confessor_request_status_id)
    end

    def confessor_request_update_params
      params.require(:confessor_request).permit(:first_name, :last_name, :email, :diocese_id, :confessor_request_status_id, :comments)
    end
end
