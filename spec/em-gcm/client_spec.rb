require 'spec_helper'

describe EventMachine::GCM::Client do
  let(:server_api_key) { ENV['GCM_API_KEY'] }
  let(:restricted_package_name) { ENV['PACKAGE_NAME'] }
  let(:registration_id) { ENV['REGISTRATION_ID'] }
  before(:each) do
    @notification  = {
      :restricted_package_name => restricted_package_name,
      :registration_ids => [registration_id],
      :data => { 'alert' => 'test' },
      :dry_run => true
    }
    @client = EM::GCM::Client.new(server_api_key)
  end
  describe '#deliver' do
    it 'sends a notification' do
      EM.run do
        @client.deliver(@notification) do |response|
          response.result.should_not be_nil
          response.result['results'].should_not be_nil
          response.result['results'][0]['message_id'].should_not be_nil
          EM.stop
        end
      end
    end
  end
end
