class Film < ApplicationRecord
    # Associations
    has_and_belongs_to_many :characters
    has_and_belongs_to_many :planets
    has_and_belongs_to_many :starships
    has_and_belongs_to_many :vehicles
  
    # Class Method to fetch films from API
    def self.fetch_films(page = 1)
      films = []
      url = "https://swapi.dev/api/films/?page=#{page}"
      response = HTTParty.get(url)
      if response.success?
        data = response.parsed_response
        data['results'].each do |film_data|
          film = Film.find_or_initialize_by(title: film_data['title'])
          film.update_attributes(
            director: film_data['director'],
            producer: film_data['producer'],
            release_date: film_data['release_date'],
            opening_crawl: film_data['opening_crawl']
          )
          films << film
        end
      else
        Rails.logger.error("Failed to fetch films from Star Wars API: #{response.code} - #{response.message}")
      end
      films
    end
  end