class VehiclesController < ApplicationController
  def index
    @vehicles = StarWarsApi.get_resource('vehicles')
  end

  def show
    @vehicle = StarWarsApi.get_resource('vehicles', params[:id])
    @pilots = (@vehicle['pilots'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
    @films = (@vehicle['films'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
  end
end