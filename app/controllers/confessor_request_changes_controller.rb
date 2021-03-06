class ConfessorRequestChangesController < ApplicationController
  before_filter :authenticate_user_account!
  before_filter :restrict_to_superuser
    
  # GET /confessor_request_changes
  # GET /confessor_request_changes.json
  def index
    @confessor_request_changes = ConfessorRequestChange.all
  end

  # GET /confessor_request_changes/1
  # GET /confessor_request_changes/1.json
  def show
    @confessor_request_change = ConfessorRequestChange.find(params[:id])
  end
end
