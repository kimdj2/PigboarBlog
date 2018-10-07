class Image < ApplicationRecord
    #アップロード
    mount_uploader :file, ImageUploader
    before_destroy :destroy_assets
    #ファイル情報が残っている場合はファイル情報を削除し、保存する。
    def destroy_assets
        self.file.remove! if self.file
        self.save!
    end
end
