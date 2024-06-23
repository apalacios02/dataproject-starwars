class StarshipsController < ApplicationController
  def index
    @starships = StarWarsApi.get_resource('starships')
  end

  def show
    @starship = StarWarsApi.get_resource('starships', params[:id])
  end
end