class ConfessorRequestStatusesController < ApplicationController
  before_action :set_confessor_request_status, only: [:show]

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
end
