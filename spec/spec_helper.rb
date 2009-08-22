require File.expand_path(File.join(File.dirname(__FILE__), "..", "init"))

require 'rubygems'
require 'sinatra'
require 'spec'
require 'webrat'
require 'rack/test'


Webrat.configure do |config|
  config.mode = :rack
  config.application_framework = :sinatra
  config.application_port = 4567
end

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

Spec::Runner.configure do |config|
  
  def app
    Rack::Builder.app do
      use Rack::Session::Cookie
      Main.new
    end
  end
  
  config.include(Rack::Test::Methods)
  
  # additional matchers
  config.include(Webrat::Methods)
  config.include(Webrat::Matchers)

  config.before(:each) do
    begin
      CouchRest.delete((SiteConfig.url_base_db || '') + SiteConfig.db_name)
    rescue RestClient::ResourceNotFound
    ensure
      CouchRest.database!((SiteConfig.url_base_db || '') + SiteConfig.db_name)
    end
  end
end
