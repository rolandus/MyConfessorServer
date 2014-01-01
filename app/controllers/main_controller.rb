class MainController < ApplicationController
  # GET /main
  def index
  end
  
  #GET /test
  def test
  end
  
  #GET /admin
  def admin
    cookies['roland'] = {
      :value => 'scott',
      :expires => Time.now + 10*60,
      :path => '/'
    }
    render layout: "admin"
  end

  #GET /confessor
  def confessor
    render layout: "confessor"
  end
  
  #GET /ping
  def ping
    respond_to do |format|
      format.html
      format.json
    end
  end
end
