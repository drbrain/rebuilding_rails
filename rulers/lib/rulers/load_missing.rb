require "rulers/refinements"

class Object
  using Rulers::Refinements::LoadMissing

  def self.const_missing name
    path = [
      to_path,
      name.to_require_name
    ].compact

    require path.join "/"

    self.const_get name
  rescue LoadError
    super
  end
end
