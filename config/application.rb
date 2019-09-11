require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.stylesheets false    # CSS/JSファイル生成せず
      g.javascripts false    # trueなら routes.rb変更せず
      g.helper false         # ヘルパー生成せず
      g.test_framework false # テストファイル生成せず
    end
    config.i18n.default_locale = :ja
    # Railsが表示の際に扱うタイムゾーン
    config.time_zone = 'Tokyo'
    # Rails(Activerecord)がDBへのRead・Writeを行う際タイムゾーン
    config.active_record.default_timezone = :local
  end
end
