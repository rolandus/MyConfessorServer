class MainController < ApplicationController
  before_filter :authenticate_user_account!, only: [:admin, :priest]
  before_filter :restrict_to_admin, only: [:admin]
  
  # GET /
  def index
    #@confessors = Confessor.all
    @locations = ConfessionLocation.all
    @available_locations = {}
    @locations.each do |location|
      confessors = Confessor.where(:confession_status_id => [1, 2], :confession_location_id => location.id)
      if confessors.length > 0
        @available_locations[location] = confessors
      end
    end
    @dioceses = Diocese.all
  end
  
  #GET /admin
  def admin
    redirect_to confessor_requests_url
  end

  #GET /priest
  def priest
    if (current_user_account.is_confessor?)
      redirect_to priest_status_url
    else
      redirect_to admin_url
    end
  end


  #GET /test
  def test
  end
  
  #GET /ping
  def ping
    respond_to do |format|
      format.html
      format.json
    end
  end
end
