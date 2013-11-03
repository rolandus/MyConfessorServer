class ConfessorsController < ApplicationController
  before_action :set_confessor, only: [:show, :edit, :update, :destroy]

  # GET /confessors
  # GET /confessors.json
  def index
    @confessors = Confessor.all
  end

  # GET /confessors/1
  # GET /confessors/1.json
  def show
  end

  # GET /confessors/new
  def new
    @confessor = Confessor.new
  end

  # GET /confessors/1/edit
  def edit
  end

  # POST /confessors
  # POST /confessors.json
  def create
    @confessor = Confessor.new(confessor_params)

    respond_to do |format|
      if @confessor.save
        format.html { redirect_to @confessor, notice: 'Confessor was successfully created.' }
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
      if @confessor.update(confessor_params)
        format.html { redirect_to @confessor, notice: 'Confessor was successfully updated.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def confessor_params
      params.require(:confessor).permit(:confessor_office_id, :salutation, :confession_status_id, :confession_location_id, :confession_start_time, :confession_end_time, :confession_comments, :biography)
    end
end
