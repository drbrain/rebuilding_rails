require "minitest/autorun"
require "rack/test"
require "rulers"

class RulerstestController < Rulers::Controller
  def action
    "it worked"
  end
end

