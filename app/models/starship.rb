class Starship < ApplicationRecord
    # Associations
    has_and_belongs_to_many :films
    has_and_belongs_to_many :pilots
  
    # Validations
    validates :name, presence: true, uniqueness: true
    validates :model, presence: true
    validates :manufacturer, presence: true
    validates :starship_class, presence: true
    validates :cost_in_credits, presence: true
    validates :length, presence: true, numericality: { greater_than: 0 }
  
    # Class Method to fetch starships from API
    def self.fetch_starships(page = 1)
      starships = []
      url = "https://swapi.dev/api/starships/?page=#{page}"
      response = HTTParty.get(url)
      if response.success?
        data = response.parsed_response
        data['results'].each do |starship_data|
          starship = Starship.find_or_initialize_by(name: starship_data['name'])
          starship.update(
            model: starship_data['model'],
            manufacturer: starship_data['manufacturer'],
            starship_class: starship_data['starship_class'],
            cost_in_credits: starship_data['cost_in_credits'],
            length: starship_data['length']
          )
          starships << starship
        end
      else
        Rails.logger.error("Failed to fetch starships from Star Wars API: #{response.code} - #{response.message}")
      end
      starships
    end
  end
  