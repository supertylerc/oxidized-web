require 'oxidized'
module Oxidized
  module Web
    module Models
      class Nodes < Sinatra::Base
        require 'time'
        attr_accessor :nodes
        def initialize
          @nodes = settings.nodes.list
          normalize!
        end

        private
        def normalize!
          @nodes.map! do |node|
            node[:last] = iso8601 node[:last]
            node[:group] ||= 'default'
            node[:full_name] = "#{node[:group]}/#{node[:name]}" if node[:full_name] == node[:name]
            node[:vars] ||= {}
            node
          end
        end

        def iso8601(last_run)
          if last_run
            last_run[:start] = Time.parse(last_run[:start].to_s).iso8601
            last_run[:end] = Time.parse(last_run[:end].to_s).iso8601
          end
          last_run || {}
        end
      end
    end
  end
end
