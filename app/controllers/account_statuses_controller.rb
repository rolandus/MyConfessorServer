class AccountStatusesController < ApplicationController
  # GET /account_statuses
  # GET /account_statuses.json
  def index
    @account_statuses = AccountStatus.all
  end

  # GET /account_statuses/1
  # GET /account_statuses/1.json
  def show
    @account_status = AccountStatus.find(params[:id])
  end
end
