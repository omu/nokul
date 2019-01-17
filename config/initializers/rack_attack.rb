# frozen_string_literal: true

module Rack
  class Attack
    # Rack::Attack stores blocked requests in configured cache store.
    # However, caching is often disabled in development environment.
    # If you want to experiment with Rack::Attack, you can temporarily enable caching in development environment:
    # Run rails dev:cache to toggle caching.
    cache.store = ActiveSupport::Cache::MemoryStore.new

    # SPAM: a single IP can make 60 requests per minute
    throttle('req/ip', limit: 300, period: 5.minutes) do |req|
      req.ip unless req.path.start_with?('/assets')
    end

    # BruteForce: a single IP can try logging in 30 times in 2 minutes
    throttle('logins/ip', limit: 30, period: 2.minutes) do |req|
      req.ip if req.path == '/devise/users/sign_in' && req.post?
    end

    # SPAM: A single ID number parameter can be submitted 6 reqs/minute
    throttle('limit logins per id_number', limit: 6, period: 60.seconds) do |req|
      req.params['id_number'] if req.path == '/devise/users/sign_in' && req.post?
    end

    # SPAM: Block PHP and Wordpress bots
    blocklist('bad-robots') do |req|
      req.ip if /\S+\.php/.match?(req.path)
    end

    # allow requests from localhost
    safelist('allow from localhost') do |req|
      req.ip == '127.0.0.1' || req.ip == '::1'
    end

    # allow requests from Tenant subnet
    safelist_ip(Tenant.configuration.network.subnet)
  end
end
