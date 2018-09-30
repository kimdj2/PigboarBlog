class Image < ApplicationRecord
    mount_uploader :file, ImageUploader
    before_destroy :destroy_assets

    def destroy_assets
        self.file.remove! if self.file
        self.save!
    end
end
