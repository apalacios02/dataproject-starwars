class PeopleController < ApplicationController
  before_action :set_person, only: [:show]

  def index
    if params[:query].present?
      @people = search_people(params[:query])
    elsif params[:type] == 'jedi'
      @people = fetch_jedi_people
    elsif params[:type] == 'sith'
      @people = fetch_sith_people
    else
      page = params[:page].to_i.positive? ? params[:page].to_i : 1
      @people = fetch_all_people(page)
    end

    @total_pages = total_pages
    @current_page = params[:page].to_i.positive? ? params[:page].to_i : 1
  end

  def show
    @films = @person['films'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @vehicles = @person['vehicles'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @starships = @person['starships'].map { |url| StarWarsApi.get_resource_by_url(url) }
    @homeworld = StarWarsApi.get_resource_by_url(@person['homeworld'])
    @is_jedi = jedi_names.include?(@person['name'])
    @is_sith = sith_names.include?(@person['name'])
  end

  private

  def fetch_all_people(page)
    people = []
    url = "https://swapi.dev/api/people/?page=#{page}"
    response = HTTParty.get(url)
    if response.success?
      data = response.parsed_response
      people = data['results']
    else
      flash.now[:alert] = 'Failed to fetch people from Star Wars API'
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
      flash.now[:alert] = 'Failed to fetch total number of people from Star Wars API'
      total_pages = 1  # Default to 1 page if API request fails
    end
    total_pages
  end

  def search_people(query)
    people = []
    url = "https://swapi.dev/api/people/?search=#{query}"
    response = HTTParty.get(url)
    if response.success?
      data = response.parsed_response
      people = data['results']
    else
      flash.now[:alert] = 'Failed to search people from Star Wars API'
    end
    people
  end

  def fetch_jedi_people
    people = []
    jedi_list = jedi_names
    jedi_list.each do |jedi|
      url = "https://swapi.dev/api/people/?search=#{jedi}"
      response = HTTParty.get(url)
      if response.success?
        data = response.parsed_response
        people.concat(data['results'])
      else
        flash.now[:alert] = 'Failed to fetch Jedi from Star Wars API'
      end
    end
    people
  end

  def fetch_sith_people
    people = []
    sith_list = sith_names
    sith_list.each do |sith|
      url = "https://swapi.dev/api/people/?search=#{sith}"
      response = HTTParty.get(url)
      if response.success?
        data = response.parsed_response
        people.concat(data['results'])
      else
        flash.now[:alert] = 'Failed to fetch Sith from Star Wars API'
      end
    end
    people
  end

  def jedi_names
    # List of known Jedi names. This list can be extended or modified based on the dataset or API
    ["Luke Skywalker", "Obi-Wan Kenobi", "Yoda", "Mace Windu", "Anakin Skywalker", "Rey", "Qui-Gon Jinn"]
  end

  def sith_names
    # List of known Sith names. This list can be extended or modified based on the dataset or API
    ["Darth Vader", "Darth Sidious", "Darth Maul", "Count Dooku", "Darth Plagueis", "Kylo Ren"]
  end

  def set_person
    @person = StarWarsApi.get_resource('people', params[:id])
  end
end
