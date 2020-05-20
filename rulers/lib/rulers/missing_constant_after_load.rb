##
# Raised when a constant is still missing after requiring the file

class Rulers::MissingConstantAfterLoad < Rulers::Error
  ##
  # The file that was loaded

  attr_reader :file_loaded

  ##
  # Constants found after loading the file

  attr_reader :found

  ##
  # The name of the missing constant

  attr_reader :name

  ##
  # Parent class or module with the missing constant

  attr_reader :parent

  def initialize parent, name, file_loaded, found
    @found       = found
    @file_loaded = file_loaded
    @name        = name
    @parent      = parent

    found_message =
      if @found.empty?
        "(none)"
      else
        found.join "\n\t"
      end

    super <<-MESSAGE
Unable to find #{name} in #{parent} after loading #{file_loaded}

Did find constants:
\t#{found_message}
    MESSAGE
  end
end
