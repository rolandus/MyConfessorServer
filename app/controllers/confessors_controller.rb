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
    if @is_accessing_self
      @edit_mode = :status
      render action: 'edit'
    else
      redirect_to action: 'edit'
    end
  end
  
  # Get /confessors/1/settings/edit
  def edit_settings
    if @is_accessing_self
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
      if @confessor.save 
        save_confessor_history("Created")
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
      #Get change comments, if relevant
      change_comments = nil
      if current_user_account.is_admin and params[:confessor_change]
        change_comments = params[:confessor_change][:change_comments]
      end
      
      #Perform the update
      if @confessor.update(confessor_params)
        # Hacky way of determining if the current update should be logged or not. 
        #The real way to check this would be to make sure something other than confession info was updated.        
        if (params[:confessor][:confessor_office_id])
          save_confessor_history(change_comments)
        end 
        format.html { redirect_to @confessor, notice: 'Confessor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confessor.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_confessor
      @confessor = Confessor.find(params[:id])
    end

    # Confessor is accessing himself if he's logged in, is a confessor, and has the same confessor ID as the one requested.
    def set_is_accessing_self
      @is_accessing_self = (
        current_user_account and (
          current_user_account.confessor and current_user_account.confessor.id == @confessor.id
        )
      )
    end
    
    # Allowed confessor params are defined in application_controller.
end
