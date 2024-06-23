class StarshipsController < ApplicationController
  def index
    @starships = StarWarsApi.get_resource('starships')
  end

  def show
    @starship = StarWarsApi.get_resource('starships', params[:id])
    @pilots = (@starship['pilots'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
    @films = (@starship['films'] || []).map { |url| StarWarsApi.get_resource_by_url(url) }
  end
end