module Utility
  module Regional
    module Can
      class Province
        names = []
        ISO3166::Country['CA'].subdivisions.each_pair { |k, v| names << [v['name'], k] }
        ABBR = names.collect(&:last).sort

        def self.iso_code_from_name(name)
          names.select { |province| province.flatten if province.first.downcase == name.try(:downcase) }.flatten.last
        end

        def self.iso_code_from_postal_code(postal_code)
          fsa = postal_code.slice(0..2).upcase
          if (iso = POSTAL_CODE_FSA[fsa])
            iso
          else
            POSTAL_CODE_FSA[fsa.slice(0)]
          end
        end

        # http://www.columbia.edu/kermit/postal-ca.html
        #     : sips tea :
        POSTAL_CODE_FSA = {
          'K1A' => %w[ON QC],
          'X0A' => 'NU',
          'X0B' => 'NU',
          'X0C' => 'NU',
          'A' => 'NL',
          'B' => 'NS',
          'C' => 'PE',
          'E' => 'NB',
          'G' => 'QC',
          'H' => 'QC',
          'J' => 'QC',
          'K' => 'ON',
          'L' => 'ON',
          'M' => 'ON',
          'N' => 'ON',
          'P' => 'ON',
          'R' => 'MB',
          'S' => 'SK',
          'T' => 'AB',
          'V' => 'BC',
          'X' => 'NT',
          'Y' => 'YT'
        }.freeze
      end
    end
  end
end
