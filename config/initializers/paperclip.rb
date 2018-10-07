Rails.application.config.before_initialize do
  Paperclip::Attachment.default_options[:url] = ":#{ENV["S3_BUCKET_NAME"]}.s3.amazonaws.com"

  Paperclip::Attachment.default_options[:path] = ':attachment/:id/:style.:extension'
end

Paperclip::Attachment.default_options[:s3_host_name] = 's3.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = 'us-east-1'
Paperclip::Attachment.default_options[:bucket] = ENV["S3_BUCKET_NAME"]
# Paperclip::Attachment.default_options[:default_url] = "/images/default/thumb_noimage.jpg"