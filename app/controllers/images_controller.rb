class ImagesController < ApplicationController
    protect_from_forgery :except => [:create]

    def create
      # Take upload from params[:file] and store it somehow...
      # Optionally also accept params[:hint] and consume if needed
      @image = Image.new(image_params)
      @image.save
      respond_to do |format|
        format.json { render :json => { url: @image.file.url } }
      end
    end
    def new
      @image = Image.build.params(image_params)
    end
   
    def show
      @image = Image.find(params[:id])
    end
   
    private
   
    def image_params
      params.require(:upload).permit(
        :file,
        :hint,
        :alt,
        )
    end
   
  end
  
  