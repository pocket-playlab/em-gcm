require 'spec_helper'
require 'pp'

describe EventMachine::GCM::Client do
  let(:sender_id) { '898507416628' }
  let(:registration_id) { '1' }
  before(:each) do
    @notification  = EM::GCM::Notification.new(:registration_ids => [registration_id], :data => { 'alert' => 'test'})
    @client = EM::GCM::Client.new
  end
  describe '#deliver' do
    it 'sends a notification' do
      EM.run do
        @client.deliver(@notification)
        EM.add_timer(1) do
          EM.stop
        end
      end
    end
  end
  # describe '#on_success' do
  #   it 'triggers callback on deliver success' do
  #     EM.run do
  #       @client.on_success do |response|
  #         pp response
  #         EM.stop
  #       end

  #       @client.on_error do |response|
  #         pp response
  #         EM.stop
  #       end

  #       @client.deliver(@notification)
  #     end
  #   end
  # end
  describe '#on_error' do
    it 'triggers callback on deliver error' do
      EM.run do
        # @client.on_success do |response|
        #   pp response
        #   EM.stop
        # end

        @client.on_error do |response|
          pp response
          EM.stop
        end

        @client.deliver(@notification)
      end
    end
  end
end