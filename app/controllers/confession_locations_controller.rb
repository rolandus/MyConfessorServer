class ConfessionLocationsController < ApplicationController
  before_action :set_confession_location, only: [:show, :edit, :update, :destroy]

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
  end

  # POST /confession_locations
  # POST /confession_locations.json
  def create
    @confession_location = ConfessionLocation.new(confession_location_params)

    respond_to do |format|
      if @confession_location.save
        format.html { redirect_to @confession_location, notice: 'Confession location was successfully created.' }
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
      if @confession_location.update(confession_location_params)
        format.html { redirect_to @confession_location, notice: 'Confession location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confession_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confession_locations/1
  # DELETE /confession_locations/1.json
  def destroy
    @confession_location.destroy
    respond_to do |format|
      format.html { redirect_to confession_locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confession_location
      @confession_location = ConfessionLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confession_location_params
      params.require(:confession_location).permit(:name, :nickname, :street_address, :city, :state_id, :postal_code)
    end
end
