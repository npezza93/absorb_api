# frozen_string_literal: true

module AbsorbApi
  class Configuration
    attr_accessor :url, :absorbuser, :absorbpass, :absorbkey
  end

  cattr_accessor :configuration

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
