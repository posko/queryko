# Migration responsible for creating a table with activities
class CreateAccounts < ActiveRecord::Migration[5.1]
  # Create table
  def change
    create_table :accounts do |t|
      t.string 	:name
      t.timestamps
    end
  end
end
