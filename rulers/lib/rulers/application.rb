class Rulers::Application
  def call env
    if env["PATH_INFO"] == "/favicon.ico" then
      return [404, {}, []]
    end

    controller, action = get_controller_and_action env

    body = controller.send action

    [200, { "Content-Type" => "text/html" }, [body]]
  end

  def get_controller_and_action env
    path_info = env.fetch "PATH_INFO"
    parts     = path_info.split "/", 4

    _, name, action, = parts

    controller_class = Object.const_get "#{name.capitalize}Controller"

    controller = controller_class.new env

    return controller, action
  end
end
