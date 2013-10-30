require 'bundler'
Bundler.setup :default, (ENV['RACK_ENV'] || 'development')

require 'sprockets'
require 'rack/rewrite'
require 'compass'
require 'sprockets-sass'
require 'coffee-script'
require 'zurb-foundation'

project_root = File.expand_path(File.dirname(__FILE__))

assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path(File.join(project_root, 'assets'))
assets.append_path(File.join(project_root, 'assets', 'javascripts'))
assets.append_path(File.join(project_root, 'assets', 'stylesheets'))
assets.append_path(File.join(project_root, 'assets', 'images'))
assets.append_path(File.join(project_root, 'assets', 'data'))
assets.append_path(File.join(project_root, 'assets', 'fonts'))
assets.append_path(File.join(project_root, 'assets', 'vendor/assets'))

puts(assets.paths)

assets.context_class.class_eval do
  def asset_path(path, options = {})
    "/assets/#{path}"
  end
end

map '/build' do
  run assets
end

#use Rack::Static, :urls => [""]

map '/' do
  run lambda { |env|
    [
        200,
        {
            'Content-Type' => 'text/html',
            'Cache-Control' => 'public, max-age=86400'
        },
        File.open('index.html', File::RDONLY)
    ]
  }
end