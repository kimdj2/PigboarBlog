class ImageUploader < CarrierWave::Uploader::Base
    
    #本番の環境の場合
    if Rails.env.production?
        #AmazonS3を使うためにfogを使用
        storage :fog
    #テストまたは開発環境の場合
    else
        #ファイルクラスを使用
        storage :file
    end
    
    #アップロード先
    def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
    
    #アップロード可能な拡張子
    def extension_white_list
    %w(jpg jpeg gif png)
    end
end

