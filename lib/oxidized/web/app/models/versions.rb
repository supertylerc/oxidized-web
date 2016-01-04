require 'oxidized'
module Oxidized
  module Web
    module Models
      class Versions < Sinatra::Base
        require 'time'
        attr_accessor :versions
        def initialize(node, group)
          # This will probably change in the future.
          # See supertylerc/oxidized-web#16.
          group = nil if group == 'default'
          @versions = settings.nodes.version node, group
          normalize!
        end

        private

        def normalize!
          @versions.map! do |v|
            v[:commit] = {
              hash: v[:oid],
              date: iso8601(v[:date]),
              message: v[:message],
              author: {
                name: v[:author][:name],
                email: v[:author][:email],
                date: iso8601(v[:author][:time]),
              }
            }
            v.select { |k, v| k == :commit }
          end
        end

        def iso8601(t)
          Time.parse(t.to_s).iso8601
        end
      end
    end
  end
end
