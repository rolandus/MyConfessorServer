class StatesController < ApplicationController
  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  # GET /states/1
  # GET /states/1.json
  def show
    @state = State.find(params[:id])
  end
end
