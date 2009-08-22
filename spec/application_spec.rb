require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  
  it "shows the default index page" do
    get '/'
    last_response.should be_ok
    last_response.body[0].should have_tag('title', /#{SiteConfig.title}/)
  end
  
end
