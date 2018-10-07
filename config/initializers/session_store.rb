# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_repo_star_session'
#ログイン保持用
Rails.application.config.session_store :cookie_store, key: '_starlistz_session', expire_after: 2.day
