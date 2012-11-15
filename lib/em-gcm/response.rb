module EventMachine
  module GCM
    class Response

      attr_reader :error, :status, :duration, :error_status, :result

      def initialize(http={}, start=nil)
        @duration = Time.now.to_f - start.to_f if start
        @status = http.response_header.status
        case @status
        when 401
          @error = 'InvalidServerApiKey'
        when 400
          @error = 'InvalidJSON'
          @error_status = http.response
        when 200
          @result = JSON.parse(http.response)
          if @result['failure'] == 1
            @error = @result['results'].first['error']
          end
        when 0
          @error = 'NetworkError'
          @error_status = http.error
        end
      end
    end
  end
end