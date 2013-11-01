class ConfessorStatusesController < ApplicationController
  # GET /confessor_statuses
  # GET /confessor_statuses.json
  def index
    @confessor_statuses = ConfessorStatus.all
  end

  # GET /confessor_statuses/1
  # GET /confessor_statuses/1.json
  def show
    @confessor_status = ConfessorStatus.find(params[:id])
  end
end
