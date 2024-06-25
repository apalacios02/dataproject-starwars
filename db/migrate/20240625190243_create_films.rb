class CreateFilms < ActiveRecord::Migration[7.1]
  def change
    create_table :films do |t|
      t.string :title
      t.string :director
      t.string :producer
      t.date :release_date
      t.text :opening_crawl

      t.timestamps
    end
  end
end
