require 'pry'
require 'httparty'
require 'nokogiri'
require 'json'

module Scraper
  class WHL
    include HTTParty

    base_uri 'https://lscluster.hockeytech.com/feed/'

    def schedule
      response = request({ view: 'schedule' })
      response['SiteKit']['Schedule']
    end

    def teams
      response = request({ view: 'teamsbyseason' })
      response['SiteKit']['Teamsbyseason']
    end

    def player(id)
      response1 = request({ player_id: id, view: 'player', category: 'profile' })
      response2 = request({ player_id: id, view: 'player', category: 'seasonstats' })

      { 
        profile: response1['SiteKit']['Player'], 
        stats:   response2['SiteKit']['Player'] 
      }
    end

    private

    def request(options, path = "")
      if ((response = self.class.get(path, params(options))).code == 200)
        response = JSON.parse(response.body)
      else
        response = nil
      end

      response
    end

    def default_options
      { 
        feed: 'modulekit',
        key: '2976319eb44abe94',
        client_code: 'ohl',
        season_id: '68',
        fmt: 'json',
      }
    end

    def params(options)
      { query: default_options.merge(options) }
    end
  end
end
