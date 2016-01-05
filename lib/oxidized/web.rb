require 'sinatra/base'

Dir["#{File.dirname(__FILE__)}/web/app/routes/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/web/app/models/*.rb"].each { |file| require file }
$LOAD_PATH << File.expand_path('../', __FILE__)

module Oxidized
  module Web
    class App < Sinatra::Base
      use Routes::Nodes
      use Routes::Versions
    end

    class WebApp
      require 'rack/handler'
      attr_reader :thread
      Rack::Handler::WEBrick = Rack::Handler.get(:puma)
      def initialize(nodes, listen)
        Sinatra::Base.set :nodes, nodes
        listen, uri = listen.split '/'
        addr, port = listen.split ':'
        port, addr = addr, nil if not port
        uri = '/' + uri.to_s
        @opts = {
          Host: addr,
          Port: port
        }
        @app = Rack::Builder.new do
          map uri do
            run App
          end
        end
      end

      def run
        @thread = Thread.new { Rack::Handler::Puma.run @app, @opts }
      end
    end
  end
end
