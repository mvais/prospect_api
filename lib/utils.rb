module Prospect
  class Utils
    @leagues = {
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
  end
end
