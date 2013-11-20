class ConfessorRequestsController < ApplicationController
  before_action :set_confessor_request, only: [:show, :edit, :update, :destroy]

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

    respond_to do |format|
      if @confessor_request.save
        format.html { redirect_to @confessor_request, notice: 'Confessor request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @confessor_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @confessor_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confessor_requests/1
  # PATCH/PUT /confessor_requests/1.json
  def update
    respond_to do |format|
      if @confessor_request.update(confessor_request_params)
        format.html { redirect_to @confessor_request, notice: 'Confessor request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confessor_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confessor_requests/1
  # DELETE /confessor_requests/1.json
  def destroy
    @confessor_request.destroy
    respond_to do |format|
      format.html { redirect_to confessor_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessor_request
      @confessor_request = ConfessorRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_request_params
      params.require(:confessor_request).permit(:first_name, :last_name, :diocese_id, :state_id, :confessor_request_status_id, :reviewer_comments, :reviewer_id)
    end
end
