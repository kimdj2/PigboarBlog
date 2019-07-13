class ImagesController < ApplicationController
  protect_from_forgery :except => [:create]
  
  #イメージ登録
  def create
    @image = Image.new(image_params)
      #イメージを登録する。
      if @image.save
        #イメージURLを戻り値として返す。
        render json: {
          image: {
            url: @image.file.url
          }
        }, content_type: "text/html"
      else
        #登録に失敗した場合
        render :json　=> { error: "イメージアップロードに失敗しました。" }, status: :unprocessable_entity
      end
  end

  def new
    @image = Image.build.params(image_params)
  end

  def show
    @image = Image.find(params[:id])
  end

  private
  #パラメータを取得する。
  def image_params
    puts "5"
    params.permit(
      :file,
      :hint,
      :alt
      )
  end
end
  
  