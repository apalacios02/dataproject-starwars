class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :manufacturer
      t.string :vehicle_class
      t.string :cost_in_credits
      t.string :length

      t.timestamps
    end
  end
end
