require "erubis"

##
# A controller handles some grouping of application functionality.

class Rulers::Controller
  using Rulers::Refinements::ClassToFile

  attr_reader :env

  def initialize env
    @env = env
  end

  def controller_name
    self.class.to_underscore
  end

  def render view, **locals
    template_file =
      Rulers.app.root.join "app", "views", controller_name, "#{view}.html.erb"

    template = template_file.read

    eruby = Erubis::Eruby.new template
    eruby.result locals.merge env: @env
  end
end
