Rails.application.config.before_initialize do
  Paperclip::Attachment.default_options[:url] = ':starlistz-bucket.s3.amazonaws.com'

  Paperclip::Attachment.default_options[:path] = ':attachment/:id/:style.:extension'
end

Paperclip::Attachment.default_options[:s3_host_name] = 's3-ap-northeast-1.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = 'ap-northeast-1'
Paperclip::Attachment.default_options[:bucket] = 'starlistz-bucket'
Paperclip::Attachment.default_options[:default_url] = "/images/default/thumb_noimage.jpg"