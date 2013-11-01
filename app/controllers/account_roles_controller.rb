class AccountRolesController < ApplicationController
  # GET /account_roles
  # GET /account_roles.json
  def index
    @account_roles = AccountRole.all
  end

  # GET /account_roles/1
  # GET /account_roles/1.json
  def show
    @account_role = AccountRole.find(params[:id])
  end
end
