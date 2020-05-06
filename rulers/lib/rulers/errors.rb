##
# Rulers error base class
#
# All Rulers errors are rack-compatible and will show up as something mildly
# readable if they don't get rescued and handled before reaching
# Application#call.

class Rulers::Error < RuntimeError
  ##
  # Rack environment for this error.

  attr_reader :env

  ##
  # HTTP status of this error.  Defaults to 500

  attr_reader :status

  def initialize(*)
    @env = { "Content-Type" => "text/html" }

    super

    @status ||= 500
  end

  ##
  # Default HTML message for an error containing the error class in the page
  # title and header and #message in the body.

  def html_message
    [<<-HTML]
<!DOCTYPE html>

<title>Error #{self.class}</title>
<h1>Error #{self.class}</h1>

<p>#{message}
    HTML
  end

  ##
  # Returns a rack-compatible response with an appropriate error status

  def response
    [@status, @env, html_message]
  end
end

##
# Raised when there is no controller matching a name

class Rulers::NoSuchController < Rulers::Error
  ##
  # The name from the path component that the #controller_name was based on

  attr_reader :name

  ##
  # The controller name that no matching class was found for

  attr_reader :controller_name

  def initialize name, controller_name, env
    @name            = name
    @controller_name = controller_name
    @env             = env

    @status = 404

    super "Controller #{@controller_name} does not exist"
  end
end
