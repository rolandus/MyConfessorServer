class AccountRolesController < ApplicationController
  before_action :set_account_role, only: [:show, :edit, :update, :destroy]

  # GET /account_roles
  # GET /account_roles.json
  def index
    @account_roles = AccountRole.all
  end

  # GET /account_roles/1
  # GET /account_roles/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_role
      @account_role = AccountRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_role_params
      params.require(:account_role).permit(:name)
    end
end
