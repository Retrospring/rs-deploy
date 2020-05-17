# This file is managed by Ansible.  Changes made here will be lost.

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 6 }.to_i
threads threads_count, threads_count

environment ENV.fetch("RAILS_ENV") { "production" }

workers 6

preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
