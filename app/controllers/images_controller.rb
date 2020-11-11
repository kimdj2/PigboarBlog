class ImagesController < ApplicationController
  protect_from_forgery :except => [:image_upload]
  before_action :authenticate_request!, only: [:image_upload]

  def upload_image
    image_param = params[:image]
    if image_param.present?
      @image_path = Imgur.new(Rails.application.credentials.imgur_key).anonymous_upload(image_param)
    end
    render json: {image_url: @image_path}, status: :ok
  end
end
  
  