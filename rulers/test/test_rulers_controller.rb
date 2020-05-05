require_relative "helper"

class TestRulersController < Minitest::Test
  def setup
    @env  = { "PATH_INFO" => "/testrulers/action" }
    @cont = RulerstestController.new @env
  end

  def test_env
    assert_equal @env, @cont.env
  end
end
