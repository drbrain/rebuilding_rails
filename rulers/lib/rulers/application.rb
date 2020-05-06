class Rulers::Application
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

  def handle_error e
    e.response
  end
end
