class ConfessorStatusesController < ApplicationController
  before_action :set_confessor_status, only: [:show]

  # GET /confessor_statuses
  # GET /confessor_statuses.json
  def index
    @confessor_statuses = ConfessorStatus.all
  end

  # GET /confessor_statuses/1
  # GET /confessor_statuses/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessor_status
      @confessor_status = ConfessorStatus.find(params[:id])
    end
end
