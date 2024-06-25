class CreateStarships < ActiveRecord::Migration[7.1]
  def change
    create_table :starships do |t|
      t.string :model
      t.string :manufacturer
      t.string :starship_class
      t.string :cost_in_credits
      t.string :length

      t.timestamps
    end
  end
end
