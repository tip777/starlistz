require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Starlistz
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo' #日本時間に変更
    config.active_record.default_timezone = :local #DB に書かれる時刻を日本語に
    config.action_view.embed_authenticity_token_in_remote_forms = true#フォロー機能用
  end
end
