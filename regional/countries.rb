module Utility
  module Regional
    class Countries
      NAMES = ['United States', 'Canada'].freeze
      ABBR = %w[US CA].freeze
      POSTAL_CODE_REGEX = /(?<us>^\d{5}(-\d{4})?$)|(?<ca>^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$)/

      def self.postal_code_match?(postal_code)
        POSTAL_CODE_REGEX.match(postal_code)
      end

      def self.country_region_from_postal_code(postal_code)
        if match_data = postal_code_match?(postal_code)
          if match_data[:us]
            { country: 'US',
              state: Utility::Regional::Usa::State.iso_code_from_postal_code(postal_code.first(5)),
              postal_code: postal_code }
          elsif match_data[:ca]
            { country: 'CA',
              state: Utility::Regional::Can::Province.iso_code_from_postal_code(postal_code),
              postal_code: postal_code }
          end
        end
      end
    end
  end
end
