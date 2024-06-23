class PeopleController < ApplicationController
  def index
    @people = StarWarsApi.get_resource('people')
  end

  def show
    @person = StarWarsApi.get_resource('people', params[:id])
  end
end
