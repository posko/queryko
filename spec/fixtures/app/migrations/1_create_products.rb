# Migration responsible for creating a table with activities
class CreateProducts < ActiveRecord::Migration[5.1]
  # Create table
  def change
    create_table :products do |t|
      t.string 	:name
      t.timestamps
    end
  end
end
