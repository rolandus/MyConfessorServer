class ConfessionLocationChangesController < ApplicationController
  before_action :set_confession_location_change, only: [:show]

  # GET /confession_location_changes
  # GET /confession_location_changes.json
  def index
    @confession_location_changes = ConfessionLocationChange.all
  end

  # GET /confession_location_changes/1
  # GET /confession_location_changes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confession_location_change
      @confession_location_change = ConfessionLocationChange.find(params[:id])
    end
end
