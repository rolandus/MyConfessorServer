class ConfessorRequestsController < ApplicationController
  before_action :set_confessor_request, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user_account!, except: [:new, :create]
  before_filter :restrict_to_admin, except: [:new, :create]
  
  layout "admin_inside"
    
  # GET /confessor_requests
  # GET /confessor_requests.json
  def index
    @filter = params[:filter]
    if !@filter then @filter = "pending" end
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
  def edit
    @edit_mode = :edit
  end

  # POST /confessor_requests
  # POST /confessor_requests.json
  def create
    @confessor_request = ConfessorRequest.new(confessor_request_params)
    @confessor_request.confessor_request_status_id = 1 #Set the status to 1-Created.
    @confessor_request.confirmation_number = SecureRandom.hex[0, 8]
    
    respond_to do |format|
      if @confessor_request.save
        save_to_history @confessor_request.id
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
    case params[:commit]
    when "Pend"
      if @confessor_request.is_created?
        @confessor_request.confessor_request_status_id = 2
      end
    when "Approve"        
      @confessor_request.confessor_request_status_id = 3
    when "Deny"
      if @confessor_request.is_created? or @confessor_request.is_pending?
        @confessor_request.confessor_request_status_id = 4
      end
    end

    respond_to do |format|
      if @confessor_request.update(confessor_request_params) and save_to_history @confessor_request.id
        if @confessor_request.confessor_request_status_id_changed? and @confessor_request.is_approved?
          #Factor our user creation code and call it from here. Needs to create a change audit.
        end
        format.html { redirect_to @confessor_request }
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

    def save_to_history (confessor_request_id)
      confessor_request_change = ConfessorRequestChange.new(confessor_request_params)
      confessor_request_change.confessor_request_id = confessor_request_id
      confessor_request_change.changed_by_user_account_id = 2 #TODO - This needs to be the logged-in user!
      confessor_request_change.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_request_params
      params.require(:confessor_request).permit(:first_name, :last_name, :email, :diocese_id, :state_id, :confessor_request_status_id)
    end
end
