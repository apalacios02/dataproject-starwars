class PeopleController < ApplicationController
  before_action :set_person, only: [:show]

  def index
<<<<<<< HEAD
    page = params[:page].to_i.zero? ? 1 : params[:page].to_i
    @people = fetch_all_people(page)
    @total_pages = total_pages
    @current_page = page
=======
    @people = Kaminari.paginate_array(fetch_all_people).page(params[:page]).per(10)
>>>>>>> cb73fbefc9a855f4f934ffc8d33b2516d6c141e8
  end

  def show
    @films = @person['films'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @vehicles = @person['vehicles'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @starships = @person['starships'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @homeworld = StarWarsApi.get_resource_by_url(@person['homeworld'])
  end

  private

  def fetch_all_people(page = 1)
    people = []
    url = "https://swapi.dev/api/people/?page=#{page}"
    response = HTTParty.get(url)
    if response.success?
      data = response.parsed_response
      people = data['results']
    else
      flash[:alert] = 'Failed to fetch people from Star Wars API'
    end
    people
  end

  def total_pages
    url = "https://swapi.dev/api/people/"
    response = HTTParty.get(url)
    if response.success?
      data = response.parsed_response
      total_count = data['count']
      total_pages = (total_count.to_f / 10).ceil  # Assuming 10 results per page based on SWAPI default
    else
      flash[:alert] = 'Failed to fetch total number of people from Star Wars API'
      total_pages = 1  # Default to 1 page if API request fails
    end
    total_pages
  end

  def set_person
    @person = StarWarsApi.get_resource('people', params[:id])
  end
end
