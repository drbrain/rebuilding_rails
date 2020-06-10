module Rulers::Refinements::ClassToFile
  refine Class do
    using Rulers::Refinements::ToUnderscore

    def to_underscore
      name.
        sub(/Controller$/, "").
        to_underscore
    end
  end
end
