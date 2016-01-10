require 'oxidized'
module Oxidized
  module Web
    module Models
      class Versions < Sinatra::Base
        require 'time'
        attr_accessor :versions
        def initialize
          nodes = Nodes.new!.nodes
          # The following creates a multidimensional array allows a Hash to be created later
          @versions = nodes.map do |n|
            versions = normalize(settings.nodes.version(n[:name], n[:group]))
            [
              n[:group].to_sym,
              { :"#{n[:name].to_sym}" => versions }
            ]
          end
          @versions = Hash[@versions]
        end

        def find(group, hostname)
          @versions[group.to_sym][hostname.to_sym]
        end

        private

        def normalize(versions)
          versions.map! do |v|
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
