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

  def show
  end

  def index
  end

  def create
  end

end
