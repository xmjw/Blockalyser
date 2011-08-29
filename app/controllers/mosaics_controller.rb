class MosaicsController < ApplicationController
  # GET /mosaics
  # GET /mosaics.xml
  def index
    @mosaics = Mosaic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mosaics }
    end
  end

  # GET /mosaics/1
  # GET /mosaics/1.xml
  def show
    @mosaic = Mosaic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mosaic }
    end
  end

  # GET /mosaics/new
  # GET /mosaics/new.xml
  def new
    @mosaic = Mosaic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mosaic }
    end
  end

  # GET /mosaics/1/edit
  def edit
    @mosaic = Mosaic.find(params[:id])
  end

  # POST /mosaics
  # POST /mosaics.xml
  def create
    @mosaic = Mosaic.new(params[:mosaic])

    respond_to do |format|
      if @mosaic.save
        format.html { redirect_to(@mosaic, :notice => 'Mosaic was successfully created.') }
        format.xml  { render :xml => @mosaic, :status => :created, :location => @mosaic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mosaic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mosaics/1
  # PUT /mosaics/1.xml
  def update
    @mosaic = Mosaic.find(params[:id])

    respond_to do |format|
      if @mosaic.update_attributes(params[:mosaic])
        format.html { redirect_to(@mosaic, :notice => 'Mosaic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mosaic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mosaics/1
  # DELETE /mosaics/1.xml
  def destroy
    @mosaic = Mosaic.find(params[:id])
    @mosaic.destroy

    respond_to do |format|
      format.html { redirect_to(mosaics_url) }
      format.xml  { head :ok }
    end
  end
end
