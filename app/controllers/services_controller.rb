class ServicesController < ApplicationController

  # GET /api/v1/services.json
  def index
    @services = Service.all(:order => :name)

    respond_to do |format|
      format.html
      format.json  { render :json => {:services => @services } }
    end
  end

  # GET /api/v1/services/1.json
  def show
    @service = Service.find_by_slug!(params[:id])

    respond_to do |format|
      format.html
      format.json  { render :json => @service }
    end
  end

  # GET /api/v1/services/new.json
  def new
    @service = Service.new

    respond_to do |format|
      format.json  { render :json => @service }
    end
  end

  # POST /api/v1/services.json
  def create
    puts params
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to(@service, :notice => 'Service was successfully created.') }
        format.json  { render :json => @service, :status => :created }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/services/1.json
  def update
    @service = Service.find_by_slug!(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to(@service, :notice => 'Service was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/services/1.json
  def destroy
    @service = Service.find_by_slug!(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to(services_url) }
      format.json  { head :ok }
    end
  end
end
