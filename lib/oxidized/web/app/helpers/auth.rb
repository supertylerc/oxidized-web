require 'oxidized'
require 'openssl'
module Oxidized
  module Web
    module Helpers
      def valid_key?
        halt 403 unless env['HTTP_AUTHORIZATION']
        auth_header = env['HTTP_AUTHORIZATION'].split(':')
        client_id = auth_header[0]
        signature = auth_header[1]
        client = Models::Users.first(client_id: client_id)
        halt 403 if client.nil?
        data = request.path
        error 401 unless sign(client[:client_secret], data) == signature
      end

      def sign(client_secret, data)
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), client_secret, data)
      end
    end
  end
end
