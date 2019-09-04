require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Starlistz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo' #日本時間に変更
    config.active_record.default_timezone = :local #DB に書かれる時刻を日本語に
    config.action_view.embed_authenticity_token_in_remote_forms = true#フォロー機能用
    config.filter_parameters += [:first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, :zipcode, :prefecture, :prefecture_id, :city, :address1, :address2, :phone_number, :name, :email, :title, :message, :description, :price, :status, :news_letter, :list_sold, :stripe_charge_id, :uid, :provider, :nickname, :followers_count, :artist, :song, :description, :recommend, :row_order, :insta_url, :tw_url, :stripe_acct_id, :stripe_cus_id, :stripe_acct_secret, :secret_key, :identity, :tos_acceptance, :tos_acceptance_date]
  end
end
