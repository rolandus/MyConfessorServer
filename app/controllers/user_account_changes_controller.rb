class UserAccountChangesController < ApplicationController
  before_action :set_user_account_change, only: [:show]

  # GET /user_account_changes
  # GET /user_account_changes.json
  def index
    @user_account_changes = UserAccountChange.all
  end

  # GET /user_account_changes/1
  # GET /user_account_changes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_account_change
      @user_account_change = UserAccountChange.find(params[:id])
    end
end
