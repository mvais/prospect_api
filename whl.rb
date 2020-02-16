require 'pry'
require 'httparty'
require 'nokogiri'
require 'json'

module Scraper
  class WHL
    include HTTParty

    base_uri 'https://lscluster.hockeytech.com/feed/'

    def initialize
      @options = { 
        query: { 
          feed: 'modulekit',
          key: '2976319eb44abe94',
          client_code: 'ohl',
          season_id: '68',
          fmt: 'json',
        }
      }
    end

    def schedule
      response = request({ view: 'schedule', tab: '', category: '' })
      response['SiteKit']['Schedule']
    end

    def teams
      response = request({ view: 'teamsbyseason', tab: '', category: '' })
      response['SiteKit']['Teamsbyseason']
    end

    def player(id)
      response = request({player_id: id, view: 'player', category: 'profile' })
      response['SiteKit']['Player']
    end

    private

    def request(options)
      @options[:query] = params(options)

      if ((response = self.class.get("", @options)).code == 200)
        JSON.parse(response.body)
      else
        nil
      end
    end

    def params(options)
      options = options.filter { |key, value| [key, value] if value != "" }
      
      @options[:query].merge(options)
    end
  end
end
