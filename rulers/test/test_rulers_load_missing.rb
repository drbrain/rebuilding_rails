require_relative "helper"

class TestRulersLoadMissing < Minitest::Test
  def setup
    @load_fixtures = (FIXTURES + "load_missing").to_s

    $LOAD_PATH.unshift @load_fixtures
  end

  def teardown
    $LOAD_PATH.delete @load_fixtures
  end

  def test_const_missing_loadable
    before = $LOADED_FEATURES.dup

    Object.const_missing :Loadable

    required = $LOADED_FEATURES - before

    assert_equal 1, required.size

    assert_match "loadable.rb", required.first
  end

  def test_const_missing_wrong_name
    e = assert_raises Rulers::MissingConstantAfterLoad do
      Object.const_missing :WrongName
    end

    assert_equal Object,       e.parent
    assert_equal :WrongName,   e.name
    assert_equal "wrong_name", e.file_loaded
    assert_equal [:Wrongname], e.found
  end
end
