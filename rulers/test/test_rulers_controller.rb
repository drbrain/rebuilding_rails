require_relative "helper"

class TestRulersController < Minitest::Test
  def setup
    @app = Rulers.new root: FIXTURES
    Rulers.app = @app

    @env  = { "PATH_INFO" => "/testrulers/action" }
    @cont = RulerstestController.new @env
  end

  def teardown
    Rulers.app = nil

    $LOAD_PATH.delete_if do |path|
      path.start_with? FIXTURES.to_s
    end
  end

  def test_controller_name
    assert_equal "rulerstest", @cont.controller_name
  end

  def test_env
    assert_equal @env, @cont.env
  end

  def test_render
    rendered = @cont.render "hello", var: "value"

    expected = <<-EXPECTED
var value: "value"
    EXPECTED

    assert_equal expected, rendered
  end
end
