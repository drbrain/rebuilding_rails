require "rulers/refinements"

class Object
  using Rulers::Refinements::LoadMissing

  def self.const_missing name
    path = [
      to_path,
      name.to_require_name
    ].compact

    known = constants.dup

    file = path.join "/"

    require file

    loaded = constants - known

    # This handles loading of wrong constants.
    #
    # Either the constant got loaded by the #require above or it did not.  If
    # it did not we can show what was loaded and from which file so the user
    # can maybe figure things out.
    #
    # We don't need to worry about multiple threads because ruby places a lock
    # around #require to prevent a program from running code inside a
    # partially-loaded file.  By the time we reach the above line the constant
    # will be loaded or not.
    #
    # We could be confused by a second require in another thread loading the
    # constant correctly before we do, but I don't care about that.
    #
    # TODO: This should use $LOADED_FEATURES instead of the required file for
    # more targeted debugging, but that we can do on another day when we get
    # confused and need it.
    unless loaded.include? name then
      error = Rulers::MissingConstantAfterLoad.new self, name, file, loaded

      raise error
    end

    self.const_get name
  rescue LoadError
    super
  end
end
