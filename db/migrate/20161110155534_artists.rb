class Artists < ActiveRecord::Migration[5.0]
  def change
  	create_table :artists do |table|
  		table.string :name
  		table.string :genre
  	end
  end
end
