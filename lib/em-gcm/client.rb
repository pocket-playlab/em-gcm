module EventMachine
  module GCM
    class Client
      URL = "https://android.googleapis.com/gcm/send"

      attr_reader :server_api_key

      def initialize(server_api_key)
        @server_api_key = server_api_key
      end

      def deliver(notification, &block)
        @start = Time.now.to_f
        http = EventMachine::HttpRequest.new(URL).post(
        :body => notification.to_json,
        :head   => {
          "Authorization"   => "key=#{server_api_key}",
          "Content-Type"    => "application/json",
          "User-Agent"      => ['em-gcm-',EventMachine::GCM::VERSION].join
        })

        http.callback do
          response = EM::GCM::Response.new(http, @start)
          block.call(response) unless block.nil?
        end

        http.errback do |e|
          response = EM::GCM::Response.new(http, @start)
          block.call(response) unless block.nil?
        end
      end
    end
  end
end