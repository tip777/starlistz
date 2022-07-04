source 'https://rubygems.org'
ruby "2.5.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

#追加
#gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'erb2haml'
gem 'ransack', '~> 2.1.1'
gem 'kaminari', '~> 0.17.0'
# gem 'aws-sdk', '~> 2.3'
gem 'aws-sdk-s3', '~> 1'
gem "paranoia", "~> 2.2"
gem "gretel"
gem 'mysql2', '~> 0.4.4'
gem 'select2-rails'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'nokogiri', '~> 1.6'
# gem 'rename'
gem "cocoon"
gem 'simple_form'
gem 'ranked-model', '~> 0.4.0'
gem 'stripe'
gem 'gon'
gem 'rails-i18n'
gem "bootsnap", ">= 1.1.0", require: false #rails 5.2.2 で標準で必要なよう
gem 'meta-tags'

gem 'carrierwave'
gem 'fog'

gem "recaptcha"

#mimemagic railsでエラー問題
gem "mimemagic", "~> 0.3.10"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet' #N+1問題検出
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'byebug', platform: :mri
  gem 'pry-rails'  # rails console(もしくは、rails c)でirbの代わりにpryを使われる
  gem 'pry-byebug' # デバッグを実施(Ruby 2.0以降で動作する)
  gem 'rails-erd' # ER図自動生成
end

# herokuでのログ表示のため
# gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
