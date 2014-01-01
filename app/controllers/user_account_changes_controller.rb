class UserAccountChangesController < ApplicationController
  before_filter :authenticate_user_account!
  
  # GET /user_account_changes
  # GET /user_account_changes.json
  def index
    @user_account_changes = UserAccountChange.all
  end

  # GET /user_account_changes/1
  # GET /user_account_changes/1.json
  def show
    @user_account_change = UserAccountChange.find(params[:id])
  end
end
