module Prospect
  class Utils
    @leagues = {
      ahl: {
        code: 'ahl',
        season_ids: [65],
        key: '50c2cd9b5e18e390'
      },
      bchl: {
        code: 'bchl',
        season_ids: [40],
        key: 'ca4e9e599d4dae55'
      },
      cchl: {
        code: 'cchl',
        season_ids: [44],
        key: '18e5d35386c4a5a7'
      },
      ohl: {
        code: 'ohl',
        season_ids: [68],
        key: '2976319eb44abe94'
      },
      whl: {
        code: 'whl',
        season_ids: [270],
        key: '41b145a848f4bd67'
      },
      qmjhl: {
        code: 'lhjmq',
        season_ids: [193],
        key: 'f322673b6bcae299'
      },
      ushl: {
        code: 'ushl',
        season_ids: [71],
        key: 'e828f89b243dc43f'
      },
      sjhl: {
        code: 'sjhl',
        season_ids: [46],
        key: '2fb5c2e84bf3e4a8'
      }
    }

    def self.fetch_season_id(league)
      symbol = league&.downcase&.to_sym

      if @leagues.key?(symbol)
        @leagues[symbol][:season_ids].last
      end
    end

    def self.fetch_key(league)
      symbol = league&.downcase&.to_sym

      if @leagues.key?(symbol)
        @leagues[symbol][:key]
      end
    end

    def self.fetch_code(league)
      symbol = league&.downcase&.to_sym

      if @leagues.key?(symbol)
        @leagues[symbol][:code]
      end
    end

    def self.valid_league?(league)
      @leagues.key?(league&.downcase&.to_sym)
    end
  end
end
