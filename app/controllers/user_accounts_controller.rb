class UserAccountsController < ApplicationController
  before_filter :authenticate_user_account! #One must be logged in to do anything with a UserAccount
  before_filter :restrict_to_superuser, except: [:show, :edit, :update]

  before_action :set_user_account, only: [:show, :edit, :update, :destroy]
  before_action :restrict_to_self, only: [:show, :edit, :update]
  
  layout "admin_inside"
  
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
    @edit_mode = :new
  end

  # GET /user_accounts/1/edit
  def edit
    @edit_mode = :edit
  end

  # POST /user_accounts
  # POST /user_accounts.json
  def create
    @user_account = UserAccount.new(user_account_params)
    @user_account.account_status_id = 2  #2 - Active. Always make new users active.
    respond_to do |format|
      if @user_account.save() and save_to_history("Created") and handle_confessor_info
        format.html { redirect_to @user_account, notice: 'User account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_account }
      else
        @edit_mode = :new
        format.html { render action: 'new' }
        format.json { render json: @user_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_accounts/1
  # PATCH/PUT /user_accounts/1.json
  def update
    respond_to do |format|
      comments = nil
      if params[:user_account_change]
        comments = params[:user_account_change][:change_comments]
      end
      if @user_account.update(user_account_params) and save_to_history(comments) and handle_confessor_info
        format.html { redirect_to @user_account, notice: 'User account was successfully updated.' }
        format.json { head :no_content }
      else
        @edit_mode = :edit
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
    
    # Helper to only allow this action on self, unless you are a superuser
    def restrict_to_self
      if not current_user_account.is_superadmin and @user_account.id != current_user_account.id
        render text: '{ error: "401 Unauthorized access" }', status: 401
       end
    end
    
    #Helper to handle saving confessor info
    def handle_confessor_info
      if @user_account.is_confessor  #Only allow this if user has the confessor role
        if @user_account.confessor
          # Confessor exists and we are updating it...
          @confessor = @user_account.confessor
          @confessor.update(confessor_params)
          if @confessor.changed?
            save_confessor_history(params[:user_account_change][:change_comments]) #Copy change comments into confessor change, too.
          end
        else
          # We are creating a new confessor...
          @confessor = Confessor.new(confessor_params)
          @confessor.user_account = @user_account
          @confessor.confession_status_id = 1
          @confessor.save()
          save_confessor_history("Created")
          #@user_account.confessor = @confessor
          @user_account.save()
        end
      else
        return true
      end
    end

    #Helper to save UserAccount changes to the history
    def save_to_history (comments)
      user_account_change = UserAccountChange.new(user_account_change_params)
      user_account_change.user_account_id = @user_account.id
      user_account_change.email = @user_account.email
      user_account_change.change_comments = comments
      user_account_change.changed_by_user_account_id = current_user_account.id
      user_account_change.save()
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_account_params
      params.require(:user_account).permit(:first_name, :last_name, :password, :account_status_id, :email, :home_phone, :work_phone, :mobile_phone, :account_role_ids => [])
    end
    
    def user_account_change_params
      params.require(:user_account).permit(:first_name, :last_name, :account_status_id, :home_phone, :work_phone, :mobile_phone)
    end
    
    # Allowed confessor params are defined in application_controller
end
