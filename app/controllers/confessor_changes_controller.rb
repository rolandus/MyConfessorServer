class ConfessorChangesController < ApplicationController
  before_filter :authenticate_user_account!
  
  # GET /confessor_changes
  # GET /confessor_changes.json
  def index
    @confessor_changes = ConfessorChange.all
  end

  # GET /confessor_changes/1
  # GET /confessor_changes/1.json
  def show
    @confessor_changes = ConfessorChange.find(params[:id])
  end
end
