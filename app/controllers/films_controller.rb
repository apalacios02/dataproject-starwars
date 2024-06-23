class FilmsController < ApplicationController
  def index
    @films = StarWarsApi.get_resource('films')
  end

  def show
    @film = StarWarsApi.get_resource('films', params[:id])
    @people = (@film['characters'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
    @vehicles = (@film['vehicles'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
    @starships = (@film['starships'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
    @planets = (@film['planets'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
  end
end
