# app/controllers/about_pages_controller.rb
class AboutPagesController < ApplicationController
  def show
    @about_page = AboutPage.first # Adjust this based on your application logic to fetch the AboutPage content
  end
end