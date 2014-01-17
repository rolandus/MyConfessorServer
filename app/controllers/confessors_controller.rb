class ConfessorsController < ApplicationController
  before_action :set_confessor, except: [:new, :create, :index]
  before_action :set_is_accessing_self, except: [:new, :create, :index]
  before_filter :authenticate_user_account!, except: [:index, :show, :status]
  before_filter :restrict_to_admin, only: [:edit, :new, :create]

  # GET /confessors
  # GET /confessors.json
  def index
    @confessors = Confessor.all
  end

  # GET /confessors/1
  # GET /confessors/1.json
  def show
  end

  # GET /confessors/1/status
  def status
    # Show status only
  end
  
  # GET /confessors/new
  def new
    @confessor = Confessor.new
  end

  # GET /confessors/1/edit
  def edit
    @edit_mode = :full
  end
  
  # GET /confessors/1/status/edit
  def edit_status
    if @is_accessing_self then
      @edit_mode = :status
      render action: 'edit'
    else
      redirect_to action: 'edit'
    end
  end
  
  # Get /confessors/1/settings/edit
  def edit_settings
    if @is_accessing_self then
      @edit_mode = :settings
      render action: 'edit'
    else
      redirect_to action: 'edit'
    end
  end

  # POST /confessors
  # POST /confessors.json
  def create
    @confessor = Confessor.new(confessor_params)
    @confessor.user_account_id = params[:user_account][:user_account_id]
    respond_to do |format|
      if @confessor.save and save_confessor_history @confessor.id, params[:user_account][:user_account_id], "Created"
        format.html { redirect_to @confessor, notice: 'Confessor was successfully created: ' + params[:user_account][:user_account_id] }
        format.json { render action: 'show', status: :created, location: @confessor }
      else
        format.html { render action: 'new' }
        format.json { render json: @confessor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confessors/1
  # PATCH/PUT /confessors/1.json
  def update
    respond_to do |format|
      @confessor.user_account_id = params[:user_account][:user_account_id]
      if @confessor.update(confessor_params) and save_confessor_history @confessor.id, params[:user_account][:user_account_id], params[:confessor_change][:change_comments]
        format.html { redirect_to @confessor, notice: 'Confessor was successfully updated: ' + params[:user_account][:user_account_id] }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confessor.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessor
      @confessor = Confessor.find(params[:id])
    end

    # User is accessing himself if he's logged in, is a confessor, and has the same confessor ID as the one requested.
    def set_is_accessing_self
      @is_accessing_self = (current_user_account and (current_user_account.confessor and current_user_account.confessor.id == @confessor.id))
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_params
      params.require(:confessor).permit(:confessor_office_id, :diocese_id, :salutation, :confession_status_id, :confession_location_id, :confession_start_time, :confession_end_time, :confession_comments, :biography)
    end
    
    def confessor_change_params
      params.require(:confessor).permit(:confessor_office_id, :diocese_id, :salutation, :biography)
    end
end
