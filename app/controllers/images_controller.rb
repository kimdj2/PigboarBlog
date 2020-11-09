class ImagesController < ApplicationController
  protect_from_forgery :except => [:image_upload]
  before_action :authenticate_request!, only: [:image_upload]

  def upload_image
    image_param = params[:image]
    if image_param.present?
      @image_path = Imgur.new('97261fb9958613a').anonymous_upload(image_param)
    end
    render json: {image_url: @image_path}, status: :ok
  end
end
  
  