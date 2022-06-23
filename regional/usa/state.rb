module Utility
  module Regional
    module Usa
      class State
        names = []
        ISO3166::Country['US'].subdivisions.each_pair { |k, v| names << [v['name'], k] }
        ABBR = names.collect(&:last).sort

        def self.name_from_iso_code(code)
          ISO3166::Country['US'].subdivisions[code].try(:[], 'name')
        end
      end
    end
  end
end
