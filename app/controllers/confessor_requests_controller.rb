class ConfessorRequestsController < ApplicationController
  before_action :set_confessor_request, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user_account!, except: [:new, :create]
  before_filter :restrict_to_admin, except: [:new, :create]
  
  layout "admin_inside"
    
  # GET /confessor_requests
  # GET /confessor_requests.json
  def index
    @confessor_requests = ConfessorRequest.all
  end

  # GET /confessor_requests/1
  # GET /confessor_requests/1.json
  def show
  end

  # GET /confessor_requests/new
  def new
    @confessor_request = ConfessorRequest.new
  end

  # GET /confessor_requests/1/edit
  def edit
  end

  # POST /confessor_requests
  # POST /confessor_requests.json
  def create
    @confessor_request = ConfessorRequest.new(confessor_request_params)
    @confessor_request.confessor_request_status_id = 1 #Set the status to 1-Created.
    @confessor_request.state_id = @confessor_request.diocese.state_id

    respond_to do |format|
      if @confessor_request.save
        save_to_history @confessor_request.id, "Created"
        format.html { redirect_to @confessor_request, notice: "Your request has been submitted. We'll send you an email once we've verified your identity." }
        #format.html { redirect_to action: 'confirm_request' }
        format.json { render action: 'show', status: :created, location: @confessor_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @confessor_request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def confirm_request  
  end

  # PATCH/PUT /confessor_requests/1
  # PATCH/PUT /confessor_requests/1.json
  def update
    respond_to do |format|
      if @confessor_request.update(confessor_request_params) and save_to_history @confessor_request.id, params[:confessor_request_change][:change_comments]
        format.html { redirect_to @confessor_request, notice: 'Confessor request was successfully updated.' }
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

    def save_to_history (confessor_request_id, comments)
      confessor_request_change = ConfessorRequestChange.new(confessor_request_params)
      confessor_request_change.confessor_request_id = confessor_request_id
      confessor_request_change.change_comments = comments
      confessor_request_change.changed_by_user_account_id = 2 #TODO - This needs to be the logged-in user!
      confessor_request_change.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_request_params
      params.require(:confessor_request).permit(:first_name, :last_name, :email, :diocese_id, :state_id, :confessor_request_status_id)
    end
end
