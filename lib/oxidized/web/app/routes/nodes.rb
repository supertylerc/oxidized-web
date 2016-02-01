require 'json'

module Oxidized
  module Web
    module Routes
      class Nodes < Sinatra::Base
        helpers Helpers
        before do
          valid_key?
        end

        get '/nodes' do
          @data = Models::Nodes.new!
          @data.nodes.to_json
        end

        get '/nodes/:hostname' do
          @data = Models::Nodes.new!.find params[:hostname]
          @data.to_json
        end
      end
    end
  end
end
