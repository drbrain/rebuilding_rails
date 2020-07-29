require "erubis"

##
# A controller handles some grouping of application functionality.

class Rulers::Controller
  include Rulers::Model

  using Rulers::Refinements::ClassToFile

  attr_reader :env

  def initialize env
    @env = env
    @controller_start = Process.clock_gettime Process::CLOCK_MONOTONIC
  end

  def controller_name
    self.class.to_underscore
  end

  def view_context
    variables = {
      controller_name:  controller_name,
    }

    context = Erubis::Context.new
    context.update variables
    context.update self
    context
  end

  def render view, **locals
    template_file =
      Rulers.app.root.join "app", "views", controller_name, "#{view}.html.erb"

    template = template_file.read

    context = view_context
    context.update locals

    eruby = Erubis::Eruby.new template
    eruby.result context.to_hash
  end
end
