class Person < ApplicationRecord
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
  