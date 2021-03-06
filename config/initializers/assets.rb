# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

%w( welcome admin/menus admin/logolink forms profiles users).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js.coffee", "#{controller}.css"]
end

Rails.application.config.assets.precompile += %w( reset.css )
Rails.application.config.assets.precompile += %w( modernizr.custom.94336.js )
Rails.application.config.assets.precompile += %w( jquery.tagsinput.min.js )

#Rails.application.config.assets.precompile += %w( welcome.css )
#Rails.application.config.assets.precompile += %w( admin/menus.css )