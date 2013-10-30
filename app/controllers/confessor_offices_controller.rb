class ConfessorOfficesController < ApplicationController
  before_action :set_confessor_office, only: [:show]

  # GET /confessor_offices
  # GET /confessor_offices.json
  def index
    @confessor_offices = ConfessorOffice.all
  end

  # GET /confessor_offices/1
  # GET /confessor_offices/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessor_office
      @confessor_office = ConfessorOffice.find(params[:id])
    end
end
