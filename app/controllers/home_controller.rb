class HomeController < ApplicationController
  def index
    @people = StarWarsApi.get_resource('people')
    @planets = StarWarsApi.get_resource('planets')
    @films = StarWarsApi.get_resource('films')
    @vehicles = StarWarsApi.get_resource('vehicles')
    @starships = StarWarsApi.get_resource('starships')
  end
end