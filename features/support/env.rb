require File.expand_path(File.dirname(__FILE__)+'/../../spec/spec_helper')
require 'haml'

Webrat.configure do |config|
  config.mode = :rack
  config.application_framework = :sinatra
  config.application_port = 4567
end

require 'webrat/core/matchers'
require 'cucumber'

World do
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
end