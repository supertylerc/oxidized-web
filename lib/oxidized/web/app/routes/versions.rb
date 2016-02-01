require 'json'

module Oxidized
  module Web
    module Routes
      class Versions < Sinatra::Base
        helpers Helpers
        before do
          valid_key?
        end

        get '/versions/:group/:hostname' do
          Models::Versions.new!.find(params[:group], params[:hostname]).to_json
        end

        get '/versions/:group/:hostname/latest' do
          @data = Models::Versions.new!.find(params[:group], params[:hostname])
          @data.last.to_json
        end

        get '/versions' do
          @data = Models::Versions.new!
          @data.versions.to_json
        end
      end
    end
  end
end
