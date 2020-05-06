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
end
