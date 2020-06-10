require "pathname"

class Rulers
  VERSION = "1.0"

  def self.app
    @app ||= new
  end

  attr_reader :root

  def initialize
    set_load_path
  end

  def set_load_path
    loader = caller.find do |frame|
      /(?<file>.*?):\d+:in/ =~ frame

      next if file == __FILE__

      file
    end

    # assume config/application.rb
    loader = Pathname loader
    @root = loader.parent.parent

    app = @root + "app"
    app.children.each do |child|
      $LOAD_PATH.unshift child.to_s
    end
  end
end

require "rulers/load_missing"
