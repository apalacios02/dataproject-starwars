class PeopleController < ApplicationController
  def index
    @people = Kaminari.paginate_array(fetch_all_people).page(params[:page]).per(10)
  end

  def show
    @person = StarWarsApi.get_resource('people', params[:id])
    @films = @person['films'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @vehicles = @person['vehicles'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @starships = @person['starships'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @homeworld = StarWarsApi.get_resource_by_url(@person['homeworld'])
  end

  private

  def fetch_all_people
    people = []
    url = 'https://swapi.dev/api/people/'
    while url
      response = HTTParty.get(url)
      data = response.parsed_response
      people.concat(data['results'])
      url = data['next']
    end
    people
  end
end
