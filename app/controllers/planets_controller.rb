class PlanetsController < ApplicationController
  def index
    @planets = StarWarsApi.get_resource('planets')
  end

  def show
    @planet = StarWarsApi.get_resource('planets', params[:id])
    @residents = (@planet['residents'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
    @films = (@planet['films'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
  end
end