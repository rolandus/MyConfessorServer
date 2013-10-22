class ConfessionalLocationsController < ApplicationController
  before_action :set_confessional_location, only: [:show, :edit, :update, :destroy]

  # GET /confessional_locations
  # GET /confessional_locations.json
  def index
    @confessional_locations = ConfessionalLocation.where(search_params)
  end

  # GET /confessional_locations/1
  # GET /confessional_locations/1.json
  def show
  end

  # GET /confessional_locations/new
  def new
    @confessional_location = ConfessionalLocation.new
  end

  # GET /confessional_locations/1/edit
  def edit
  end

  # POST /confessional_locations
  # POST /confessional_locations.json
  def create
    @confessional_location = ConfessionalLocation.new(confessional_location_params)

    respond_to do |format|
      if @confessional_location.save
        format.html { redirect_to @confessional_location, notice: 'Confessional location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @confessional_location }
      else
        format.html { render action: 'new' }
        format.json { render json: @confessional_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confessional_locations/1
  # PATCH/PUT /confessional_locations/1.json
  def update
    respond_to do |format|
      if @confessional_location.update(confessional_location_params)
        format.html { redirect_to @confessional_location, notice: 'Confessional location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @confessional_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confessional_locations/1
  # DELETE /confessional_locations/1.json
  def destroy
    @confessional_location.destroy
    respond_to do |format|
      format.html { redirect_to confessional_locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_confessional_location
      @confessional_location = ConfessionalLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessional_location_params
      params.require(:confessional_location).permit(:name, :nickname, :street_address, :city, :state)
    end
    
    def search_params
      params.permit(:city, :state)
    end
end
