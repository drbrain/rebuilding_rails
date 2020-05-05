class Rulers::Application
  def call env
    [200, { "Content-Type" => "text/html" }, [<<-HTML]]
<!DOCTYPE html>

<title>Hello World</title>

<p>Hello world from Ruby on Rulers
    HTML
  end
end
