ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require "vendor/dependencies/lib/dependencies"
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require "couchrest"
require "ostruct"
require "haml"
require "sass"

class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end

configure do
  SiteConfig = OpenStruct.new(
                 :title           => 'Your App',                             # title of application
                 :url_base        => 'http://localhost:4567/',               # base URL for your site
                 :url_base_db     => 'http://localhost:5984/',               # base URL for CouchDB
                 :db_name         => "skeleton-#{Sinatra::Base.environment}", # database name
               )
end

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

Main.run! if Main.run?
