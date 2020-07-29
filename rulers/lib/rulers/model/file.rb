require "json"

##
# JSON file-based model
#
# There is no persistence.

class Rulers::Model::File

  ##
  # Look up entry +id+ in the quotes database.  Return +nil+ if the file does
  # not exist or there is some other problem.

  def self.find id
    file = Rulers.app.root.join "db", "quotes", "#{id}.json"

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
