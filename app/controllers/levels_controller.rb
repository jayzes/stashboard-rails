class LevelsController < ApplicationController

  # GET /api/v1/levels.json
  def index
    @levels = Level.all

    respond_to do |format|
      format.json  { render :json => {:levels => @levels.keys } }
    end
  end
  
end