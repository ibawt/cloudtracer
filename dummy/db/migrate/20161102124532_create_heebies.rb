class CreateHeebies < ActiveRecord::Migration[5.0]
  def change
    create_table :heebies do |t|
      t.string :name
      t.int :age

      t.timestamps
    end
  end
end
