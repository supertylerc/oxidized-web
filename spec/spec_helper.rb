require 'coveralls'
Coveralls.wear!

require 'rack/test'
require 'rspec'
require 'securerandom'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../lib/oxidized/web.rb', __FILE__
include Oxidized::Web::Helpers

$CLIENT_ID = SecureRandom.random_number(36**36).to_s(36)
$CLIENT_SECRET = SecureRandom.random_number(36**36).to_s(36)

module RSpecMixin
  include Rack::Test::Methods
  def app
    Oxidized::Web::App
  end

  def create_user(id, secret)
    Oxidized::Web::Models::Users.new do |u|
      u.first_name = 'Oxidized'
      u.last_name = 'Web'
      u.client_id = id
      u.client_secret = secret
      u.privilege_level = 15
      u.created_at = current_time
      u.save
    end
  end

  class TestNodes
    def self.list
      [{
        name: 'rtr1.example.com',
        last: {
          start: '2016-01-03 03:22:27 UTC',
          end: '2016-01-03 03:22:29 UTC',
          status: 'success',
          time: 1.516074609
        },
        group: 'default',
        full_name: 'default/rtr1.example.com',
        vars: {}
      }]
    end

    def self.version(hostname, _)
      [{
        oid: '9e890265f00a7369e25e7ef2de92e5f94a65a0ab',
        message: "update #{hostname}",
        author: {
          name: 'oxidized',
          time: '2016-01-02 20:06:13 UTC',
          email: 'oxidized@tylerc.me'
        },
        date: '2016-01-02 20:06:13 UTC'
      }]
    end
  end
  Sinatra::Base.set :nodes, TestNodes
end

RSpec.configure do |c|
  c.include RSpecMixin
  c.before :suite do
    Oxidized::Web::Models::Users.new do |u|
      u.first_name = 'Tyler'
      u.last_name = 'Christiansen'
      u.client_id = $CLIENT_ID
      u.client_secret = $CLIENT_SECRET
      u.privilege_level = 15
      u.created_at = Time.now.to_s
      u.save
    end
  end

  c.after :suite do
    Oxidized::Web::Models::Users.filter(client_id: $CLIENT_ID).delete
  end
end
