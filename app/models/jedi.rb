class Jedi < ApplicationRecord
  self.table_name = 'jedis'  # Set the table name to 'jedis'

  # Validations
  validates :name, presence: true
  validates :lightsaber_color, presence: true
  validates :homeworld, presence: true

  # Active Storage association
  has_one_attached :image

  # Add any additional methods or scopes as needed
  def jedi_story
    "#{name} is a Jedi from #{homeworld}. #{name} wields a #{lightsaber_color} lightsaber."
    # Add more details about the Jedi's story here
  end
end
