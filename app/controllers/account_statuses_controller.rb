class AccountStatusesController < ApplicationController
  before_action :set_account_status, only: [:show]

  # GET /account_statuses
  # GET /account_statuses.json
  def index
    @account_statuses = AccountStatus.all
  end

  # GET /account_statuses/1
  # GET /account_statuses/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_status
      @account_status = AccountStatus.find(params[:id])
    end
end
