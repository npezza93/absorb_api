module AbsorbApi
  class Configuration
    attr_accessor :url, :absorbuser, :absorbpass, :absorbkey, :ignored_lesson_types, :ignored_course_ids
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
