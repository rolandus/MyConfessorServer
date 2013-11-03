class ConfessionStatusesController < ApplicationController
  # GET /confession_statuses
  # GET /confession_statuses.json
  def index
    @confession_statuses = ConfessionStatus.all
  end

  # GET /confession_statuses/1
  # GET /confession_statuses/1.json
  def show
    @confession_status = ConfessionStatus.find(params[:id])
  end
end
