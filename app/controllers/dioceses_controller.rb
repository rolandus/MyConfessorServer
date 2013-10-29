class DiocesesController < ApplicationController
  before_action :set_diocese, only: [:show, :edit, :update, :destroy]

  # GET /dioceses
  # GET /dioceses.json
  def index
    @dioceses = Diocese.all
  end

  # GET /dioceses/1
  # GET /dioceses/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diocese
      @diocese = Diocese.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diocese_params
      params.require(:diocese).permit(:name, :full_name, :state_id)
    end
end
