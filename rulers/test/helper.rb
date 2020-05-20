require "minitest/autorun"
require "pathname"
require "pp"
require "rack/test"
require "rulers"

class RulerstestController < Rulers::Controller
  def action
    "it worked"
  end
end

helper = Pathname __FILE__
FIXTURES = helper.parent + "fixtures"

