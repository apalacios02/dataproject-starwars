class Planet < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :climate, presence: true
    validates :terrain, presence: true
    validates :population, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
    validates :rotation_period, :orbital_period, :diameter, :surface_water, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  
    def self.fetch_from_api_and_create(id)
      planet_data = StarWarsApi.get_planet(id)
      create!(
        name: planet_data['name'],
        climate: planet_data['climate'],
        terrain: planet_data['terrain'],
        population: planet_data['population'],
        rotation_period: planet_data['rotation_period'],
        orbital_period: planet_data['orbital_period'],
        diameter: planet_data['diameter'],
        gravity: planet_data['gravity'],
        surface_water: planet_data['surface_water']
      )
    end
  
    def self.sync_with_api
      planets_data = StarWarsApi.get_planets['results']
      planets_data.each do |planet_data|
        planet = find_or_initialize_by(name: planet_data['name'])
        planet.update(
          climate: planet_data['climate'],
          terrain: planet_data['terrain'],
          population: planet_data['population'],
          rotation_period: planet_data['rotation_period'],
          orbital_period: planet_data['orbital_period'],
          diameter: planet_data['diameter'],
          gravity: planet_data['gravity'],
          surface_water: planet_data['surface_water']
        )
      end
    end
  end