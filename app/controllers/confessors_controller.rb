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

  # GET /priest/status
  # GET /admin/confessors/1/status 
  def status
    if params[:id]
      @source = :confessor_status
    else
      @source = :priest_status
    end
  end
  
  # GET /confessors/new
  def new
    @confessor = Confessor.new
  end

  # GET /confessors/1/edit
  # GET /confessors/1/edit/status
  # GET /confessors/1/edit/settings
  def edit
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

        redirect_target = @confessor
        if params[:confessor][:source] == :priest_status
          redirect_target = priest_status_url
        elsif params[:confessor][:source] == :confessor_status
          redirect_target = confessor_status_url
        end
        
        format.html { redirect_to redirect_target }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confessor.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_confessor
      if params[:id]
        @confessor = Confessor.find(params[:id])
      else
        @confessor = current_user_account.confessor
      end
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
