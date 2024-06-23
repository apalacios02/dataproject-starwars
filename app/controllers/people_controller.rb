class PeopleController < ApplicationController
  def index
    @people = StarWarsApi.get_resource('people')
  end

  def show
    @person = StarWarsApi.get_resource('people', params[:id])
    @films = @person['films'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @vehicles = @person['vehicles'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @starships = @person['starships'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @homeworld = StarWarsApi.get_resource_by_url(@person['homeworld'])
  end
end