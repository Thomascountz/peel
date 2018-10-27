require "peel/version"
require "peel/modelable"
require "peel/repository"

module Peel
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :database_file

    def initialize
      @database_file = ':memory:'
    end
  end
end
