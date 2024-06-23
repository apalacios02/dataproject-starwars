class PlanetsController < ApplicationController
  def index
    @planets = StarWarsApi.get_resource('planets')
  end

  def show
    @planet = StarWarsApi.get_resource('planets', params[:id])
  end
end