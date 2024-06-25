class Person < ApplicationRecord
    validates :name, presence: true
    validates :height, presence: true
    validates :mass, presence: true
    validates :hair_color, presence: true
    validates :skin_color, presence: true
    validates :eye_color, presence: true
    validates :birth_year, presence: true
    validates :gender, presence: true
  
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
  