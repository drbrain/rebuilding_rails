module Rulers::Refinements::By
  refine Enumerator do
    def by field, value
      select { |item|
        value == item[field]
      }
    end
  end
end
