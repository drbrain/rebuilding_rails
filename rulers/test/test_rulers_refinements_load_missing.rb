require_relative "helper"

class TestRulersRefinementsLoadMissing < Minitest::Test
  using Rulers::Refinements::LoadMissing

  def test_symbol_to_require_name
    require_name = :MissingConstant.to_require_name

    assert_equal "missing_constant", require_name
  end

  def test_to_path
    expected = File.basename __FILE__, ".rb"
    assert_equal expected, self.class.to_path
  end
end
