class AddColumnsToJedis < ActiveRecord::Migration[7.1]
  def change
    add_column :jedis, :name, :string
    add_column :jedis, :homeworld, :string
    add_column :jedis, :lightsaber_color, :string
    add_column :jedis, :jedi_story, :text
  end
end
