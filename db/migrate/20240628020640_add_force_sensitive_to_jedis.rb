class AddForceSensitiveToJedis < ActiveRecord::Migration[7.1]
  def change
    add_column :jedis, :force_sensitive, :boolean
  end
end
