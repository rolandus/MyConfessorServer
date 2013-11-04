class UserAccountsController < ApplicationController
  before_action :set_user_account, only: [:show, :edit, :update, :destroy]

  # GET /user_accounts
  # GET /user_accounts.json
  def index
    @user_accounts = UserAccount.all
  end

  # GET /user_accounts/1
  # GET /user_accounts/1.json
  def show
  end

  # GET /user_accounts/new
  def new
    @user_account = UserAccount.new
  end

  # GET /user_accounts/1/edit
  def edit
  end

  # POST /user_accounts
  # POST /user_accounts.json
  def create
    @user_account = UserAccount.new(user_account_params)

    respond_to do |format|
      if @user_account.save
        format.html { redirect_to @user_account, notice: 'User account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_account }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_accounts/1
  # PATCH/PUT /user_accounts/1.json
  def update
    respond_to do |format|
      if @user_account.update(user_account_params) and save_to_history @user_account.id, params[:user_account_change][:change_comments]
        format.html { redirect_to @user_account, notice: 'User account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_accounts/1
  # DELETE /user_accounts/1.json
  #def destroy
  #  @user_account.destroy
  #  respond_to do |format|
  #    format.html { redirect_to user_accounts_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_account
      @user_account = UserAccount.find(params[:id])
    end

    def save_to_history (id, comments)
      user_account_change = UserAccountChange.new(user_account_change_params)
      user_account_change.user_account_id = id
      user_account_change.change_comments = comments
      user_account_change.changed_by_user_account_id = 2 #TODO - This needs to be the logged-in user!
      user_account_change.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_account_params
      params.require(:user_account).permit(:first_name, :last_name, :username, :password, :account_status_id, :email, :home_phone, :work_phone, :mobile_phone, :confessor_id, :account_role_ids => [])
    end
    
    def user_account_change_params
      params.require(:user_account).permit(:first_name, :last_name, :username, :password, :account_status_id, :email, :home_phone, :work_phone, :mobile_phone, :confessor_id)
    end
end
