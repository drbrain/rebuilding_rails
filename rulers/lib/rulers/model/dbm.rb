require "dbm"
require "json"

##
# DBM-based model using JSON storage

class Rulers::Model::DBM
  @dbm = nil

  ##
  # Retrieve all records from the DB.

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

  ##
  # Find a record by ID

  def self.find id
    id = String id

    return nil unless dbm.key? id

    new id
  end

  ##
  # Load or create a record from the database.
  #
  # If no +id+ is given the "next" id is chosen and used.  See #new_id for
  # caveats when creating a new record.

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

  ##
  # Retrieve the value for +field+.

  def [] field
    @attributes[field]
  end

  ##
  # Set +field+ to +value+.
  #
  # The value will not be persisted until #save is called.

  def []= field, value
    @attributes[field] = value
  end

  ##
  # HAHA, LOL, THIS IS SO UNSAFE
  #
  # DBM doesn't expose a transactional interface so it's possible that record
  # creation will collide.  To potentially minimize this we immediately store
  # an empty record in the id we found.
  #
  # This should use the ruby-bdb gem which has transactions, but I didn't want
  # to add the dependency.
  #
  #--
  #
  # This method is called before #initialize so we need to use
  # <code>self.class.dbm</code> instead of <code>@dbm</code>.

  def new_id
    dbm = self.class.dbm

    id = dbm.keys.map { |k| k.to_i }.max + 1
    dbm[id.to_s] ||= ""

    id.to_s
  end

  ##
  # Saves the attributes to the DB.

  def save
    json = JSON.dump @attributes

    @dbm[@id] = json

    true
  end

  ##
  # Merges +attributes+ into the model's attributes

  def update_attributes attributes
    @attributes.merge! attributes
  end
end

