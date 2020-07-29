require "dbm"
require "json"

##
# DBM-based model using JSON storage

class Rulers::Model::DBM
  @dbm = nil

  def self.all
    dbm.each_key.map { |id|
      find id
    }
  end

  ##
  # DBM database object

  def self.dbm
    @dbm ||=
      begin
        file = Rulers.app.root.join "db", "quotes"
        ::DBM.open file.to_s, 0644, DBM::WRCREAT
      end
  end

  def self.find id
    id = String id

    return nil unless dbm.key? id

    new id
  end

  def initialize id = new_id
    @id = String id
    @dbm = self.class.dbm

    @attributes =
      if data = @dbm[@id] then
        if data.empty? then
          {}
        else
          JSON.parse data
        end
      end
  end

  def [] field
    @attributes[field]
  end

  def []= field, value
    @attributes[field] = value
  end

  ##
  # HAHA, LOL, THIS IS SO UNSAFE
  #
  # DBM doesn't expose a transactional interface so it's possible that record
  # creation will collide.  To potentially minimize this we immediately store
  # an empty record in the id we found.

  def new_id
    dbm = self.class.dbm
    id = dbm.keys.map { |k| k.to_i }.max + 1
    dbm[id.to_s] ||= ""
    id.to_s
  end

  def save
    json = JSON.dump @attributes

    @dbm[@id] = json

    true
  end

  def update_attributes attributes
    @attributes.merge! attributes
  end
end

