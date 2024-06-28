class Film < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "director", "id", "id_value", "opening_crawl", "producer", "release_date", "title", "updated_at"]
      end
      
    def self.ransackable_associations(auth_object = nil)
        ["people", "planets", "starships", "vehicles"]
      end

    # Associations
    has_and_belongs_to_many :people
    has_and_belongs_to_many :planets
    has_and_belongs_to_many :starships
    has_and_belongs_to_many :vehicles
  
    # Validations
    validates :title, presence: true, uniqueness: true
    validates :director, presence: true
    validates :producer, presence: true
    validates :release_date, presence: true
    validates :opening_crawl, presence: true
  
    # Class Method to fetch films from API
    def self.fetch_films(page = 1)
      films = []
      url = "https://swapi.dev/api/films/?page=#{page}"
      response = HTTParty.get(url)
      if response.success?
        data = response.parsed_response
        data['results'].each do |film_data|
          film = Film.find_or_initialize_by(title: film_data['title'])
          film.update(
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
  