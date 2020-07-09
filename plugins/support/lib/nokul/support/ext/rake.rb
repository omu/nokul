# frozen_string_literal: true

require 'rake'

module Rake
  module DSL
    def hack_argv(*allowed)
      abort "Argument required: #{allowed}" if ARGV.size < 2 && !allowed.empty?

      ensure_allowed_args(*allowed)

      ARGV.each { |arg| task(arg.to_sym) {} }

      ARGV[1..].each do |resource|
        warn "====> #{resource}"
        yield resource
        warn ''
      end
    end

    private

    def ensure_allowed_args(*allowed)
      return if allowed.empty?

      ARGV[1..].each do |arg|
        abort "Allowed arguments: #{allowed}" unless allowed.include? arg
      end
    end
  end
end
