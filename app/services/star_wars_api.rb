class StarWarsApi
    include HTTParty
    base_uri 'https://swapi.dev/api'
  
    def self.get_resource(resource, id = nil)
      url = id ? "/#{resource}/#{id}/" : "/#{resource}/"
      response = get(url)
      response.parsed_response
    end
  end