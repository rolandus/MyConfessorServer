class ConfessionLocationChangesController < ApplicationController
  # GET /confession_location_changes
  # GET /confession_location_changes.json
  def index
    @confession_location_changes = ConfessionLocationChange.all
  end

  # GET /confession_location_changes/1
  # GET /confession_location_changes/1.json
  def show
    @confession_location_change = ConfessionLocationChange.find(params[:id])
  end
end
