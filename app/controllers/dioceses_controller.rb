class DiocesesController < ApplicationController
  # GET /dioceses
  # GET /dioceses.json
  def index
    @dioceses = Diocese.all
  end

  # GET /dioceses/1
  # GET /dioceses/1.json
  def show
    @diocese = Diocese.find(params[:id])
  end
end
