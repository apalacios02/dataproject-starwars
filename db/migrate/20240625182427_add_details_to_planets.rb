class AddDetailsToPlanets < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :rotation_period, :integer
    add_column :planets, :orbital_period, :integer
    add_column :planets, :diameter, :integer
    add_column :planets, :gravity, :string
    add_column :planets, :surface_water, :integer
  end
end
