class ImagesController < ApplicationController
  protect_from_forgery :except => [:image_upload]
  before_action :authenticate_request!, only: [:image_upload]

  def image_upload
    image_param = params[:image]
    if image_param["file"].present?
      @image_path = Imgur.new('97261fb9958613a').anonymous_upload(image_param["file"])
    end
    render json: {image_url: @image_path}, status: :ok
  end


  def image_upload
    @image = Image.build.params(image_params)
  end

end
  
  