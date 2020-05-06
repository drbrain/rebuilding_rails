class Rulers::Error < RuntimeError
  attr_reader :status

  def initialize(*)
    super

    @status ||= 500
  end

  def html_message
    [<<-HTML]
<!DOCTYPE html>

<title>Error #{self.class}</title>
<h1>Error #{self.class}</h1>

<p>#{message}
    HTML
  end

  def response
    [@status, { "Content-Type" => "text/html" }, html_message]
  end
end

class Rulers::NoSuchController < Rulers::Error
  attr_reader :name
  attr_reader :controller_name

  def initialize name, controller_name, env
    @name            = name
    @controller_name = controller_name
    @env             = env

    @status = 400

    super "Controller #{@controller_name} does not exist"
  end
end
