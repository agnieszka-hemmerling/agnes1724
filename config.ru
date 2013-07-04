require 'bundler/setup'
require 'rack/coffee'
require 'sass/plugin/rack'
require 'sprockets'
require './app.rb'

root = File.expand_path "../", __FILE__

#use Rack::Coffee, {
#  :root => "#{root}/public",
#  :urls => '/javascripts'
#}

use Sass::Plugin::Rack    # Compile Sass on the fly


map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/templates'
  run environment
end


map '/' do
  run Server
end
