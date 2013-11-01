class ConfessorOfficesController < ApplicationController
  # GET /confessor_offices
  # GET /confessor_offices.json
  def index
    @confessor_offices = ConfessorOffice.all
  end

  # GET /confessor_offices/1
  # GET /confessor_offices/1.json
  def show
    @confessor_office = ConfessorOffice.find(params[:id])
  end
end
