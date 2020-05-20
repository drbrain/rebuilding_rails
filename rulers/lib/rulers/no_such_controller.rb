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

