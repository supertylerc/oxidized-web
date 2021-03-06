require 'sinatra/base'
require 'sinatra/sequel'
Dir["#{File.dirname(__FILE__)}/web/app/migrations/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/web/app/helpers/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/web/app/routes/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/web/app/models/*.rb"].each { |file| require file }
$LOAD_PATH << File.expand_path('../', __FILE__)

module Oxidized
  module Web
    class App < Sinatra::Base
      helpers Helpers

      before do
        valid_key?
      end

      not_found do
        {
          error: 'Not Found Exception',
          message: 'The requested resource was not found',
          code: {
            code: 404,
            subcode: 1
          }
        }.to_json
      end

      use Routes::Nodes
      use Routes::Versions
    end

    class WebApp
      require 'rack/handler'
      attr_reader :thread
      Rack::Handler::WEBrick = Rack::Handler.get(:puma)
      def initialize(nodes, listen)
        Sinatra::Base.set :nodes, nodes
        uri = parse_listen_uri listen
        @app = Rack::Builder.new do
          map uri do
            run App
          end
        end
      end

      def run
        @thread = Thread.new { Rack::Handler::Puma.run @app, @opts }
      end

      private

      def parse_listen_uri(listen)
        listen, uri = listen.split '/'
        addr, port = listen.split ':'
        port, addr = addr, nil if not port
        @opts = {
          Host: addr,
          Port: port
        }
        "/#{uri}"
      end
    end
  end
end
