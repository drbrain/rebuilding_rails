require "json"

##
# JSON file-based model
#
# There is no persistence.

class Rulers::Model::File

  ##
  # Return all records for this model

  def self.all
    entries = dir.glob "*.json"
    entries.map { |f| new f }
  end

  ##
  # Directory where data for this model is stored

  def self.dir
    Rulers.app.root.join "db", "quotes"
  end

  ##
  # Look up entry +id+ in the quotes database.  Return +nil+ if the file does
  # not exist or there is some other problem.

  def self.find id
    file = dir.join "#{id}.json"

    new file
  rescue
    nil
  end

  ##
  # Initializes model +file+

  def initialize file
    @file = file
    @id = Integer @file.basename(".json").to_s

    @data = JSON.parse @file.read
  end

  ##
  # Read +field+ from the model

  def [] field
    @data[field.to_s]
  end

  ##
  # Write +field+ to the model

  def []= field, value
    @data[field.to_s] = value
  end
end
