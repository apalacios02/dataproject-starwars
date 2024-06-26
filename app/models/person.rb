class Person < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
        ["birth_year", "created_at", "eye_color", "gender", "hair_color", "height", "id", "id_value", "is_jedi", "is_sith", "mass", "name", "skin_color", "updated_at"]
      end
    
      def self.ransackable_associations(auth_object = nil)
        ["films", "homeworld", "starships", "vehicles"]
      end
    

    # Validations
    validates :name, presence: true
    validates :height, presence: true
    validates :mass, presence: true
    validates :hair_color, presence: true
    validates :skin_color, presence: true
    validates :eye_color, presence: true
    validates :birth_year, presence: true
    validates :gender, presence: true
  
    # Associations
    has_and_belongs_to_many :films
    belongs_to :homeworld, class_name: 'Planet', foreign_key: 'homeworld_id', optional: true
    has_and_belongs_to_many :vehicles
    has_and_belongs_to_many :starships
  
    # Method to retrieve homeworld information
    def homeworld
      @homeworld ||= StarWarsApi.get_resource_by_url(homeworld_url)
    end
  
    # Method to retrieve films information
    def films
      @films ||= films_urls.map { |url| StarWarsApi.get_resource_by_url(url) }
    end
  
    # Method to retrieve vehicles information
    def vehicles
      @vehicles ||= vehicles_urls.map { |url| StarWarsApi.get_resource_by_url(url) }
    end
  
    # Method to retrieve starships information
    def starships
      @starships ||= starships_urls.map { |url| StarWarsApi.get_resource_by_url(url) }
    end
  end
  