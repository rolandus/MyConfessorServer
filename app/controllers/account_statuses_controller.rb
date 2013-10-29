class AccountStatusesController < ApplicationController
  before_action :set_account_status, only: [:show, :edit, :update, :destroy]

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

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_status_params
      params.require(:account_status).permit(:name)
    end
end
