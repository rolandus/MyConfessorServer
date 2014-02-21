class ConfessionLocationsController < ApplicationController
  before_action :set_confession_location, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user_account!, except: [:index, :show]

  # GET /confession_locations
  # GET /confession_locations.json
  def index
    @confession_locations = ConfessionLocation.all
  end

  # GET /confession_locations/1
  # GET /confession_locations/1.json
  def show
  end

  # GET /confession_locations/new
  def new
    @confession_location = ConfessionLocation.new
  end

  # GET /confession_locations/1/edit
  def edit
    #logger.debug "Location ID: " + @confession_location.id.to_s
    #location = ConfessionLocationChange.find 1
    #logger.debug "Location" + location
  end

  # POST /confession_locations
  # POST /confession_locations.json
  def create
    @confession_location = ConfessionLocation.new(confession_location_params)

    respond_to do |format|
      if @confession_location.save and save_to_history @confession_location.id, "created"
        format.html { 
          redirect_to confession_locations_path
          #redirect_to @confession_location, notice: 'Confession location was successfully created.' 
        }
        format.json { render action: 'show', status: :created, location: @confession_location }
      else
        format.html { render action: 'new' }
        format.json { render json: @confession_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confession_locations/1
  # PATCH/PUT /confession_locations/1.json
  def update
    respond_to do |format|
      if @confession_location.update(confession_location_params) and save_to_history @confession_location.id, params[:confession_location_change][:change_comments]
        format.html { 
          redirect_to confession_locations_path
          #redirect_to @confession_location, notice: 'Confession location was successfully updated.' 
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confession_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confession_locations/1
  # DELETE /confession_locations/1.json
  #def destroy
  #  @confession_location.destroy
  #  respond_to do |format|
  #    format.html { redirect_to confession_locations_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confession_location
      @confession_location = ConfessionLocation.find(params[:id])
      @confession_location_change = ConfessionLocationChange.find_by(confession_location_id: @confession_location.id)
      @created_by_user = @confession_location_change.user_account
    end
    
    def save_to_history (id, comments)
      confession_location_change = ConfessionLocationChange.new(confession_location_params)
      confession_location_change.confession_location_id = id
      confession_location_change.change_comments = comments
      confession_location_change.user_account_id = 2 #TODO - This needs to be the logged-in user!
      confession_location_change.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confession_location_params
      params.require(:confession_location).permit(:name, :nickname, :street_address, :city, :state_id, :postal_code)
    end
        
end
