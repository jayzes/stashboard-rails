class StatusImagesController < ApplicationController

  # GET /api/v1/status-images.json
  def index
    images = Dir[Rails.root.join('public','images','status','*.png')].map { |i| {:url => "/images/status/#{File.basename(i)}", :name => File.basename(i, '.png') } }
    respond_to do |format|
      format.json  { render :json => {:images => images } }
    end
  end
end