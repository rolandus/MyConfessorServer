class MainController < ApplicationController
  # GET /main
  def index
  end
  
  #GET /test
  def test
  end
  
  #GET /admin
  def admin
    render layout: "admin"
  end
end