class ConfessorRequestStatusesController < ApplicationController
  # GET /confessor_request_statuses
  # GET /confessor_request_statuses.json
  def index
    @confessor_request_statuses = ConfessorRequestStatus.all
  end

  # GET /confessor_request_statuses/1
  # GET /confessor_request_statuses/1.json
  def show
    @confessor_request_status = ConfessorRequestStatus.find(params[:id])
  end
end
