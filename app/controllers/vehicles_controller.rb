class VehiclesController < ApplicationController
  def index
    @vehicles = StarWarsApi.get_resource('vehicles')
  end

  def show
    @vehicle = StarWarsApi.get_resource('vehicles', params[:id])
  end
end
