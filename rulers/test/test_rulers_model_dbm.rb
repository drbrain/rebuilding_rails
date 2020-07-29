require_relative "helper"
require "tmpdir"

class TestRulersModelDBM < Minitest::Test
  include Rulers::Model

  def setup
    @root = Pathname Dir.mktmpdir "test_dbm_root"

    app = @root.join "app"
    app.mkdir

    db = @root.join "db"
    db.mkdir

    @app = Rulers.new root: @root
    Rulers.app = @app
  end

  def teardown
    @root.rmtree
    DBM.reset
  end

  def test_class_all
    DBM.new.save
    DBM.new.save

    assert_equal 2, DBM.all.count
  end

  def test_class_all_none
    assert_equal 0, DBM.all.count
  end

  def test_class_all_by_submitter
    r1 = DBM.new
    r1["submitter"] = true
    r1.save

    r2 = DBM.new
    r2["submitter"] = true
    r2.save

    r3 = DBM.new
    r3["b"] = true
    r3.save

    records = DBM.all_by_submitter true

    assert_equal 2, records.count
  end

  def test_class_find
    DBM.new.save

    record = DBM.find 1

    assert_equal "1", record.id
  end

  def test_class_find_nonexistent
    assert_nil DBM.find 1
  end

  def test_index
    record = DBM.new
    record["hello"] = "world"

    assert_equal "world", record["hello"]

    from_db = DBM.new record.id

    assert_nil from_db["hello"]
  end

  def test_save
    record = DBM.new
    record["hello"] = "world"
    record.save

    from_db = DBM.new record.id

    assert_equal "world", from_db["hello"]
  end

  def test_update_attributes
    record = DBM.new
    record["a"] = 1
    record["b"] = 2
    record.update_attributes "a" => 3

    assert_equal 3, record["a"]
    assert_equal 2, record["b"]
  end
end

