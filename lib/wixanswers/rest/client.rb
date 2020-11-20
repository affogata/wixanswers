
require 'wixanswers/rest/api'
require 'wixanswers/rest/request'

module WixAnswers
  module REST
    class Client
      include WixAnswers::REST::API
      attr_accessor :bearer_token

      def perform_request(path, request_method=:get, options = {})
        WixAnswers::REST::Request.new(self, path, request_method, options).perform
      end

      # @return [Boolean]
      def bearer_token?
        !!bearer_token
      end

      # @return [Boolean]
      def credentials?
        super || bearer_token?
      end
    end
  end
end
