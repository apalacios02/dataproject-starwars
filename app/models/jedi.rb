class Jedi < ApplicationRecord
    self.table_name = 'people'
  
    # Add validations, associations, and methods as needed
    validates :name, presence: true
  
    # Example association (assuming people have a homeworld)
    belongs_to :homeworld, class_name: 'Planet', foreign_key: 'homeworld_id'
  end