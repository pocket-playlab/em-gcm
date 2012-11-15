module EventMachine
  module GCM
    class Notification

      def initialize(opts)
        @registration_ids = opts[:registration_ids]
        @data = opts[:data]
      end

      def params
        {
          :registration_ids => @registration_ids,
          :data => @data
        }
      end

    end
  end
end
