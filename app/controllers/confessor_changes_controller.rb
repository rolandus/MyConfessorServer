class ConfessorChangesController < ApplicationController
  before_filter :authenticate_user_account!
  before_filter :restrict_to_superuser
    
  # GET /confessor_changes
  # GET /confessor_changes.json
  def index
    @confessor_changes = ConfessorChange.all
  end

  # GET /confessor_changes/1
  # GET /confessor_changes/1.json
  def show
    @confessor_change = ConfessorChange.find(params[:id])
  end
end
