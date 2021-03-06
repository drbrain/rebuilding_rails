module Rulers::Refinements::ToUnderscore
  refine String do
    def to_underscore
      gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2").
        gsub(/([a-z\d])([A-Z])/, "\\1_\\2").
        downcase
    end
  end
end
