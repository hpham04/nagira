#
# More deep data structure checks
#

# Check these routes
# ----------------------------------------
#   get "/config" do 
#   get "/objects" do
#   get "/objects/:type" do |type|
#   get "/objects/:type/:name" do |type,name|
#   get "/status/:hostname/services/:service_name" do |hostname,service|
#   get "/status/:hostname/services" do |hostname|
#   get "/status/:hostname" do |hostname|
#   get "/status" do
#   get "/api" do 

require_relative '../app.rb'
require 'rack/test'
require 'pp'


describe Nagira do 

  set :environment, ENV['RACK_ENV'] || :test

  include Rack::Test::Methods
  
  def app
    @app ||= Nagira
  end

  #
  # GET /objects/...
  # ----------------------------------------
  context "/objects" do

    before :all do 
      get "/objects"
      @data = JSON.parse last_response.body

      # make sure these exist
      # $allkeys =  (%w{host service contact timeperiod} + @data.keys).uniq
    end

    (%w{host service contact timeperiod} + @data.keys).uniq.each do |obj|
      
      it "objects[#{obj}] should exist" do 
        @data[obj].should be_a_kind_of Hash
      end
      
      it "route /objects/#{obj} should respond" do 
        get "/objects/#{obj}.json"
        last_response.should be ok
        #        JSON.parse(last_response.body).should be_a_kind_of Hash
      end
    end
    
  end 
  # /objects --------------------
  
end