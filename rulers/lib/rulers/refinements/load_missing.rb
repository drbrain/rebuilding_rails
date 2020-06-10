module Rulers::Refinements::LoadMissing
  refine Symbol do
    using Rulers::Refinements::ToUnderscore

    def to_require_name
      to_s.
        to_underscore.
        tr("-", "_").
        downcase
    end
  end

  refine Class do
    using Rulers::Refinements::ToUnderscore

    def to_path
      # Can't use inheritance because Class < Object
      return nil if self == Object

      name.to_underscore
    end
  end
end
