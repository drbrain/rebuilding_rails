require_relative "helper"

class TestRulersRefinementsClassToFile < Minitest::Test
  using Rulers::Refinements::ClassToFile

  def test_class_to_underscore
    assert_equal "test_rulers_refinements_class_to_file",
                 self.class.to_underscore
  end
end
