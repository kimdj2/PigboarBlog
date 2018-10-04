class ImagesController < ApplicationController
  protect_from_forgery :except => [:create]
  
  #イメージ登録
  def create
  　# パラメータよりイメージ情報を設定する。
    @image = Image.new(image_params)
    respond_to do |format|
      #イメージを登録する。
      if @image.save
        #イメージURLを戻り値として返す。
        format.json { render :json => { url: @image.file.url } }
      else
        #登録に失敗した場合
        format.json { render :json　=> { error: "イメージアップロードに失敗しました。" }, status: :unprocessable_entity }
      end
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
    params.require(:upload).permit(
      :file,
      :hint,
      :alt,
      )
  end
end
  
  