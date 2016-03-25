if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        # Configuration for Amazon S3
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
        #:region => 'us-west-1',
        #:s3_host_name => 's3-eu-west-1.amazonaws.com'
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
end