require 'coveralls'
Coveralls.wear!

require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../lib/oxidized/web.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Oxidized::Web::App end
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
  end
  Sinatra::Base.set :nodes, TestNodes
end

RSpec.configure { |c| c.include RSpecMixin }
