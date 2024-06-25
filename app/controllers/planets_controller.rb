class PlanetsController < ApplicationController
  def index
    planets_data = StarWarsApi.get_resource('planets')
    @planets = planets_data['results']
  end

  def show
    @planet = StarWarsApi.get_resource('planets', params[:id])
    @residents = fetch_associated_resources(@planet['residents'])
    @films = fetch_associated_resources(@planet['films'])
  end

  private

  def fetch_associated_resources(urls)
    urls.map { |url| StarWarsApi.get_resource_by_url(url) }
  end
end
