em-gcm
===============

An Simple EventMachine based client for Google Cloud Messaging

Usage
------

    EM.run do
      client = EM::GCM::Client.new(server_api_key)
      notification = {
        :restricted_package_name => "package_name",
        :registration_ids => ["registraction_id"],
        :data => { 'alert' => 'test' },
        #:dry_run => true
      }
      client.deliver(notification) do |response|
        #Handle response or success
      end
    end

Todo
----------
More test converage!

Contributing
------------

Once you've made your great commits:

1. [Fork](https://help.github.com/articles/fork-a-repo) em-gcm
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create an [Issue](https://github.com/arielo/em-gcm/issues) with a link to your branch
5. That's it!
