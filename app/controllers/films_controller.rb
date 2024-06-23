class FilmsController < ApplicationController
  def index
    @films = StarWarsApi.get_resource('films')
  end

  def show
    @film = StarWarsApi.get_resource('films', params[:id])
  end
end