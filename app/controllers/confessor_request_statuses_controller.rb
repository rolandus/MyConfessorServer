class ConfessorRequestStatusesController < ApplicationController
  before_action :set_confessor_request_status, only: [:show, :edit, :update, :destroy]

  # GET /confessor_request_statuses
  # GET /confessor_request_statuses.json
  def index
    @confessor_request_statuses = ConfessorRequestStatus.all
  end

  # GET /confessor_request_statuses/1
  # GET /confessor_request_statuses/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessor_request_status
      @confessor_request_status = ConfessorRequestStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_request_status_params
      params.require(:confessor_request_status).permit(:name)
    end
end
