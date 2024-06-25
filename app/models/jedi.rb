class Jedi < ApplicationRecord
    self.table_name = 'people'
  
    # Add validations, associations, and methods as needed
    validates :name, presence: true
  
    # Example association (assuming people have a homeworld)
    belongs_to :homeworld, class_name: 'Planet', foreign_key: 'homeworld_id'
  
    # Active Storage association
    has_one_attached :image
  
    # Add any additional methods or scopes as needed
    def wield_lightsaber
      "#{name} wields a #{lightsaber_color} lightsaber."
    end
  end