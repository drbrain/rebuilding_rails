require_relative "helper"

class TestRulersApplication < Minitest::Test
  include Rack::Test::Methods

  attr_reader :app

  class App < Rulers::Application
  end

  def setup
    @app = App.new
  end

  def test_call
    get "/rulerstest/action"

    assert_predicate last_response, :ok?

    assert_match "it worked", last_response.body
  end

  def test_call_favicon
    get "/favicon.ico"

    assert_equal 404, last_response.status
  end

  def test_controller_and_action
    env = {
      "PATH_INFO" => "/rulerstest/action",
    }

    controller, action = @app.get_controller_and_action env

    assert_instance_of RulerstestController, controller
    assert_equal "action", action
  end

  def test_get_controller_and_action_nonexistent
    env = {
      "PATH_INFO" => "/nonexistent/action",
    }

    e = assert_raises Rulers::NoSuchController do
      @app.get_controller_and_action env
    end

    assert_equal "nonexistent", e.name
    assert_equal "NonexistentController", e.controller_name
  end

  def test_handle_error
    e = Rulers::Error.new "bogus"

    status, env, body = @app.handle_error e

    assert_equal 500, e.status
    expected = { "Content-Type" => "text/html" }
    assert_equal expected, env

    assert_match "Rulers::Error", body.join
    assert_match "bogus", body.join
  end
end
