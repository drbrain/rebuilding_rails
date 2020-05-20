module Rulers::Refinements
end

module Rulers::Refinements::LoadMissing
  refine Symbol do
    def to_require_name
      to_s.
        gsub(/::/, "/").
        gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2").
        gsub(/([a-z\d])([A-Z])/, "\\1_\\2").
        tr("-", "_").
        downcase
    end
  end

  refine Class do
    def to_path
      # Can't use inheritance because Class < Object
      return nil if self == Object

      name.downcase
    end
  end
end
