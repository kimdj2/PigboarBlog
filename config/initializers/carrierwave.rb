CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'                                           # required
    config.fog_credentials = {
        :provider =>                'AWS',                                      # required
        :aws_access_key_id =>       ENV["S3_ACCESS_KEY"],                              # required
        :aws_secret_access_key =>   ENV["S3_SECRET_KEY"],                      # required
        :region =>                  'ap-northeast-1',                           
    }
    config.fog_directory  = ENV['S3_BUCKET']              # required
    config.fog_public     = true                                              # optional, defaults to true
    config.fog_attributes = { } # optional, defaults to {}
 
    config.remove_previously_stored_files_after_update = true
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
