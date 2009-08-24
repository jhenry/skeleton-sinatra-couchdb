ENV['RACK_ENV'] = 'test'
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

Spec::Runner.configure do |config|
  
  def app
      Main.new
      Main.set :environment, :test
      Main.set :run, false
      Main.set :raise_errors, true
      Main.set :logging, false
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
