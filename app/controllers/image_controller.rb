class ImageController < ApplicationController

  def upload
    @image = Image.new()
    #save_result = DataFile.save(params[:upload])

    #@file = save_result[0]

    #@image.thumb_height = save_result[1]
    #@image.thumb_width = save_result[2]

    #@image.filename = @file

    @image.photo = params[:photo]

    @image.user = -1

    if @image.save
      render :action => :show
    else
      render :action => "index"
    end
  end

  def index
  end

  def show
      @image = Image.find(params[:id])
      send_data @image.data, :filename => @image.file_name, :type => @image.content_type
      puts @image
  end

  def create
      return if params[:attachment].blank?

      @image = Image.new
      @image.uploaded_file = params[:attachment]

      if @image.save
          puts "All good. Saved on create and rendering to :Show"
          flash[:notice] = "Thank you for your submission..."
          render :action => :show
      else
          puts "Nope. Cocked up, this isn't happening, failing to :index'"
          flash[:error] = "There was a problem submitting your attachment."
          render :action => :index
      end
  end

end
