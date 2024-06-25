require 'httparty'

class StarWarsApi
  include HTTParty
  base_uri 'https://swapi.dev/api'

  def self.get_resource(resource, id = nil)
    url = id ? "/#{resource}/#{id}/" : "/#{resource}/"
    response = get(url)
    parse_response(response)
  end

  def self.get_resource_by_url(url)
    response = get(url)
    parse_response(response)
  end

  private

  def self.parse_response(response)
    if response.success?
      response.parsed_response
    else
      raise response.response
    end
  end
end