class Planet < ApplicationRecord

    def self.ransackable_associations(auth_object = nil)
        ["films", "residents"]
      end

    def self.ransackable_attributes(auth_object = nil)
        ["climate", "created_at", "diameter", "gravity", "id", "id_value", "name", "orbital_period", "population", "rotation_period", "surface_water", "terrain", "updated_at"]
      end

    # Validations
    validates :name, presence: true, uniqueness: true
    validates :climate, presence: true
    validates :terrain, presence: true
    validates :population, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
    validates :rotation_period, :orbital_period, :diameter, :surface_water, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  
    # Associations
    has_and_belongs_to_many :films
    has_many :residents, class_name: 'Person', foreign_key: 'homeworld_id'
  
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
  