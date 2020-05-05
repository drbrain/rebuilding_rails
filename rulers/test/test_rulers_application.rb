require "minitest/autorun"
require "rack/test"
require "rulers"

class TestRulersApplication < Minitest::Test
  include Rack::Test::Methods

  attr_reader :app

  class App < Rulers::Application
  end

  def setup
    @app = App.new
  end

  def test_call
    get "/"

    assert_predicate last_response, :ok?

    assert_match "Hello World", last_response.body
  end
end
