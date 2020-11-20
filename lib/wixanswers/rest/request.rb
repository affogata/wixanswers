

module WixAnswers
  module REST
    class Request
      def initialize(client, request_method, path, options: {}, headers: {})
        @client = client

        @request_method = request_method.to_sym

        @uri = Addressable::URI.parse("#{client.base_url}/#{client.version}/#{path}")
        @path = @uri.path

        @options = options
        @headers = default_headers.merge(headers)
      end

      def perform
        response = self.send(@request_method, @uri.to_s, headers: @headers)

        response.body
      end

      def default_headers
        {'Content-Type' => 'application/json; charset=utf-8', 'Accept' => 'application/json'}
      end

      private

      def get(uri, params: {}, headers: {})
        HTTParty.get("#{uri}/#{params.to_param}", headers: headers)
      end

      def post(uri, body, headers)
        HTTParty.post(uri, body: body, headers: headers)
      end

      def put(uri, body, headers)
        HTTParty.put(uri, body: body, headers: headers)
      end

      def delete(uri, body, headers)
        HTTParty.delete(uri, body: body, headers: headers)
      end
    end
  end
end