class EventsController < ApplicationController
  
  before_filter :find_service
  
  # GET /api/v1/services/1/events.json
  def index
    @events = @service.events

    respond_to do |format|
      format.json  { render :json => {:events => @events } }
    end
  end
  
  # GET /api/v1/services/1/current.json
  def current
    @event = @service.current_event

    respond_to do |format|
      format.json  { render :json => @event }
    end
  end

  # GET /api/v1/services/1/events/2.json
  def show
    @event = @service.events.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @event }
    end
  end

  # GET /api/v1/services/1/events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.json  { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /api/v1/services/1/events.json
  def create
    @event = @service.events.build(params[:event])

    respond_to do |format|
      if @event.save!
        format.json  { render :json => @event, :status => :created }
      else
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/services/1/events/2.json
  def update
    @event = @service.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.json  { head :ok }
      else
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/services/1/events/1.json
  def destroy
    @event = @service.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end
  
  protected
  
  def find_service
    @service = Service.find_by_slug!(params[:service_id])
  end
  
end
