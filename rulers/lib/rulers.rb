require "pathname"

class Rulers
  VERSION = "1.0"

  @app = nil

  class << self
    attr_writer :app
  end

  def self.app
    @app ||= new
  end

  attr_reader :root

  def initialize root: nil
    set_load_path root
  end

  def set_load_path root_override = nil
    @root =
      if root_override then
        Pathname root_override
      else
        loader = caller.find do |frame|
          /(?<file>.*?):\d+:in/ =~ frame

          next if file == __FILE__

          file
        end
        # assume config/application.rb
        loader = Pathname loader
        loader.parent.parent
      end

    app = @root + "app"
    app.children.each do |child|
      next if child.basename.to_s == "views"

      $LOAD_PATH.unshift child.to_s
    end
  end
end

require "rulers/load_missing"
