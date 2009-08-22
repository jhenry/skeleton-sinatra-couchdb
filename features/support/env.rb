require File.expand_path(File.dirname(__FILE__)+'/../../spec/spec_helper')
require 'haml'

Webrat.configure do |config|
  config.mode = :rack_test
  config.application_framework = :rack
  config.application_port = 4567
end

World do
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
end