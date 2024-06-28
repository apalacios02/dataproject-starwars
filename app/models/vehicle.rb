class Vehicle < ApplicationRecord

    def self.ransackable_associations(auth_object = nil)
        ["films", "people"]
      end

    def self.ransackable_attributes(auth_object = nil)
        ["cost_in_credits", "created_at", "id", "id_value", "length", "manufacturer", "model", "updated_at", "vehicle_class"]
      end

    # Associations
    has_and_belongs_to_many :films
    has_and_belongs_to_many :people
  
    # Validations
    validates :name, presence: true, uniqueness: true
    validates :model, presence: true
    validates :manufacturer, presence: true
    validates :vehicle_class, presence: true
    validates :cost_in_credits, presence: true
    validates :length, presence: true
  
    # Class Method to fetch vehicles from API
    def self.fetch_vehicles(page = 1)
      vehicles = []
      url = "https://swapi.dev/api/vehicles/?page=#{page}"
      response = HTTParty.get(url)
      if response.success?
        data = response.parsed_response
        data['results'].each do |vehicle_data|
          vehicle = Vehicle.find_or_initialize_by(name: vehicle_data['name'])
          vehicle.update(
            model: vehicle_data['model'],
            manufacturer: vehicle_data['manufacturer'],
            vehicle_class: vehicle_data['vehicle_class'],
            cost_in_credits: vehicle_data['cost_in_credits'],
            length: vehicle_data['length']
          )
          vehicles << vehicle
        end
      else
        Rails.logger.error("Failed to fetch vehicles from Star Wars API: #{response.code} - #{response.message}")
      end
      vehicles
    end
  end
  