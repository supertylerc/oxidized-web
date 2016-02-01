require 'oxidized'
require 'openssl'
module Oxidized
  module Web
    module Helpers
      def valid_key?
        client = Models::Users.first(client_id: auth_header[:client_id])
        halt 403 if client.nil?
        error 401 unless sign(client[:client_secret], request.path) == auth_header[:signature]
      end

      def sign(client_secret, data)
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), client_secret, data)
      end

      private

      def auth_header
        halt 403 unless env['HTTP_AUTHORIZATION']
        auth_header = env['HTTP_AUTHORIZATION'].split(':')
        { client_id: auth_header[0], signature: auth_header[1] }
      end
    end
  end
end
