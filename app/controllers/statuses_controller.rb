class StatusesController < ApplicationController
  # GET /api/v1/statuses.json
  def index
    @statuses = Status.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {:statuses => @statuses } }
    end
  end

  # GET /api/v1/statuses/1.json
  def show
    @status = Status.find_by_slug!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @status }
    end
  end

  # GET /api/v1/statuses/new.json
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @status }
    end
  end

  # GET /api/v1/statuses/1/edit.json
  def edit
    @status = Status.find_by_slug!(params[:id])
  end

  # POST /api/v1/statuses.json
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        format.html { redirect_to(@status, :notice => 'Status was successfully created.') }
        format.json  { render :json => @status, :status => :created }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/statuses/1.json
  def update
    @status = Status.find_by_slug!(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to(@status, :notice => 'Status was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/statuses/1.json
  def destroy
    @status = Status.find_by_slug!(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.json  { head :ok }
    end
  end
end
