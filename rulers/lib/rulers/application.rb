##
# A Rulers::Application turns rack requests into responses

class Rulers::Application

  ##
  # Entrypoint from rack.  Converts the rack request in +env+ into a
  # rack-compatible response.
  #
  # Users should subclass Rulers::Application to users Rulers:
  #
  #   class MyApplication << Rulers::Application
  #   end
  #
  # If an exception occurs in the application #handle_error is called.  You
  # may override this in your application to provide any custom error
  # handling.

  def call env
    if env["PATH_INFO"] == "/favicon.ico" then
      return [404, {}, []]
    end

    controller, action = get_controller_and_action env

    body = controller.send action

    [200, { "Content-Type" => "text/html" }, [body]]
  rescue Rulers::Error => e
    handle_error e
  end

  ##
  # Returns a controller instance and action for the request in +env+ or
  # raises Rulers::NoSuchController if a matching controller class cannot be
  # found.

  def get_controller_and_action env
    path_info = env.fetch "PATH_INFO"
    parts     = path_info.split "/", 4

    _, name, action, = parts

    controller_name = "#{name.capitalize}Controller"

    begin
      controller_class = Object.const_get controller_name
    rescue NameError
      raise Rulers::NoSuchController.new name, controller_name, env
    end

    controller = controller_class.new env

    return controller, action
  end

  ##
  # By default, returns the class specific content from
  # Rulers::Error#response for +error+.
  #
  # Override this in your application and call +super+ if you want to use the
  # default behavior:
  #
  #   class MyApplication < Rulers::Application
  #     def handle_error e
  #       case e
  #       when NoSuchController then
  #         return [302, { "Location" => "/home/index" }, []]
  #       end
  #
  #       super
  #     end
  #   end

  def handle_error error
    error.response
  end
end
