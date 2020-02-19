module Prospect
  class Utils
    @leagues = {
      ohl: {
        season_ids: [68],
        key: '2976319eb44abe94'
      },
      whl: {
        season_ids: [270],
        key: '41b145a848f4bd67'
      },
      qmjhl: {
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
  end
end
