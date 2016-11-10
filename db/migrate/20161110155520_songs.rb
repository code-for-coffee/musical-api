class Songs < ActiveRecord::Migration[5.0]
  def change
  	create_table :songs do |tbl|
  		tbl.string :name
  		tbl.string :artist
  		tbl.string :duration #3:40
  	end
  end
end
