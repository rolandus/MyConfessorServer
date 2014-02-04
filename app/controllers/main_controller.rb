class MainController < ApplicationController
  before_filter :authenticate_user_account!, only: [:admin, :priest]
  before_filter :restrict_to_admin, only: [:admin]
  
  # GET /
  def index
    @confessors = Confessor.all
  end
  
  #GET /test
  def test
  end
  
  #GET /admin
  def admin
    #render layout: "admin"  #This is the layout for the JS site
    redirect_to confessor_requests_url
  end

  #GET /priest
  def priest
    #render layout: "priest"  #This is the layout for the JS site
  end
  
  #GET /ping
  def ping
    respond_to do |format|
      format.html
      format.json
    end
  end
end
