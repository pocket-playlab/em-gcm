module EventMachine
  module GCM
    class Client
      URL = "https://android.googleapis.com/gcm/send"

      def server_api_key
        ENV['GCM_API_KEY'] || 'AIzaSyD1Hma2pPbb9VjWzeYIOPoeuVLYaSmPDYs'
      end

      def deliver(notification)
        @start = Time.now.to_f
        params = notification.params
        http = EventMachine::HttpRequest.new(URL).post(
        :body => params.to_json,
        :head   => {
          "Authorization"   => "key=#{server_api_key}",
          "Content-Type"    => "application/json",
          "User-Agent"      => ['em-gcm-',EventMachine::GCM::VERSION].join
        })

        http.callback do
          response = EM::GCM::Response.new(http, @start)
          unless response.error.nil?
            @error_callback.call(response) if @error_callback
          else
            @success_callback.call(response) if @success_callback
          end
        end

        http.errback do |e|
          response = EM::GCM::Response.new(http, @start)
          @error_callback.call(response) if @error_callback
        end
      end

      def on_error(&block)
        @error_callback = block
      end

      def on_success(&block)
        @success_callback = block
      end
    end
  end
end