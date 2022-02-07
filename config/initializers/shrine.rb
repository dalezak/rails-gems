require "shrine"

Shrine.plugin :activerecord          
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :pretty_location
Shrine.plugin :derivatives
Shrine.plugin :infer_extension
Shrine.plugin :determine_mime_type
Shrine.plugin :store_dimensions
Shrine.plugin :remote_url, max_size: 20*1024*1024

if Rails.env.production?
  require "shrine/storage/s3"
  s3_options = { 
    region: ENV['AWS_REGION'],  
    bucket: ENV['AWS_BUCKET_NAME'],  
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
  Shrine.storages = { 
    cache: Shrine::Storage::S3.new(public: true, prefix: "cache", upload_options: { acl: "public-read" }, **s3_options),  
    store: Shrine::Storage::S3.new(public: true, upload_options: { acl: "public-read" }, **s3_options) 
  }  
elsif Rails.env.development?
  require "shrine/storage/file_system"
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")
  }
else
  require "shrine/storage/memory"
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new(),
    store: Shrine::Storage::Memory.new()
  }  
end  
