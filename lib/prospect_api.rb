require 'pry'
require 'httparty'
require 'json'
require_relative './utils'

module Prospect
  class API
    include HTTParty

    base_uri 'https://lscluster.hockeytech.com/feed/'

    def initialize(league = 'cchl')
      @default_options = {
        fmt: 'json',
        feed: 'modulekit',
        client_code: Prospect::Utils.fetch_code(league),
        key: Prospect::Utils.fetch_key(league),
        season_id: Prospect::Utils.fetch_season_id(league)
      }
    end

    def change_league(league)
      return unless Prospect::Utils.valid_league?(league)

      @default_options[:client_code] = Prospect::Utils.fetch_code(league)
      @default_options[:key]         = Prospect::Utils.fetch_key(league)
      @default_options[:season_id]   = Prospect::Utils.fetch_season_id(league)
    end

    def schedule
      response = request('', view: 'schedule')
      response.dig('SiteKit', 'Schedule')
    end

    def teams
      response = request('', view: 'teamsbyseason')
      response.dig('SiteKit', 'Teamsbyseason')
    end

    def player(id)
      response1 = request('', player_id: id, view: 'player', category: 'profile')
      response2 = request('', player_id: id, view: 'player', category: 'seasonstats')

      {
        "profile": response1.dig('SiteKit', 'Player'),
        "stats": response2.dig('SiteKit', 'Player')
      }
    end

    def skaters
      response = request(
        '',
        view: 'statviewtype', type: 'topscorers', first: 0, limit: 1000
      )

      response.dig('SiteKit', 'Statviewtype').reject! { |player| player["position"] == 'G' }
    end

    def goalies
      response = request(
        '/index.php',
        view: 'players', position: 'goalies', sort: 'wins', feed: 'statviewfeed', first: 0, limit: 1000
      )

      response.dig(0, 'sections', 0, 'data').map { |goalie| goalie['row'] }
    end

    private

    def request(path = '', options = {})
      response = self.class.get(path, params(options))

      return {} unless response.code == 200
      return JSON.parse(response.body[1..-2]) if jsonp?(response.body)

      JSON.parse(response.body)
    end

    def params(options)
      { query: @default_options.merge(options) }
    end

    def jsonp?(body)
      body[0] == '(' && body[-1] == ')'
    end
  end
end
