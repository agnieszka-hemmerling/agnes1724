require 'bundler'
Bundler.require
require 'sqlite3'
$db = SQLite3::Database.new "./db.sqlite3"
require './schema.rb'
require 'sinatra'
require 'sinatra/reloader'

require 'yaml'
YAML::ENGINE.yamler= 'syck'

class Server < Sinatra::Base
  register Sinatra::Routes
  register Sinatra::Flash
  register Sinatra::Reloader
  #register Sinatra::JstPages



  set :environment, :development
  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)
  set :views, 'views'
  set :sessions, true
  set :session_secret, 'foobar'
  set :slim, :pretty => true, :format => :html5
end




#  :use_html_escape => true

Dir["./routes/*.rb"].each { |file| require file }
