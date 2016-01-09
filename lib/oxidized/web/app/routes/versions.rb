require 'json'

module Oxidized
  module Web
    module Routes
      class Versions < Sinatra::Base
        get '/versions/:group/:hostname' do
          @data = Models::Versions.new! params[:hostname], params[:group]
          @data.versions.to_json
        end

        get '/versions/:group/:hostname/latest' do
          @data = Models::Versions.new! params[:hostname], params[:group]
          @data.versions.last.to_json
        end
      end
    end
  end
end
