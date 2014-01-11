class MainController < ApplicationController
  
  # GET /
  def index
  end
  
  #GET /test
  def test
  end
  
  
  
  ### Nifty JS site stuff below here.
  
  #GET /admin
  def admin
    render layout: "admin"
  end

  #GET /priest
  def priest
    render layout: "priest"
  end
  
  #GET /ping
  def ping
    respond_to do |format|
      format.html
      format.json
    end
  end
end
