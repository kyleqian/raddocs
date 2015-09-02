$: << __dir__

Encoding.default_external = Encoding::UTF_8

require 'sinatra/base'
require 'json'
require 'haml'

require 'raddocs/configuration'
require 'raddocs/app'
require 'raddocs/middleware'

require 'raddocs/models'

module Raddocs
  # @return [Raddocs::Configuration] the current configuration
  def self.configuration api, new_api=false
    @configuration_hash ||= {}
    raise "Invalid API name" if not new_api and !@configuration_hash.has_key?(api)
    @configuration_hash[api] ||= Configuration.new
  end

  # Configure Raddocs
  #
  # @example
  #   Raddocs.configure do |config|
  #     config.url_prefix = "/documentation"
  #   end
  #
  # @yieldparam configuration [Raddocs::Configuration]
  def self.configure api
    yield configuration(api, new_api=true) if block_given?
  end
end