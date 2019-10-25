class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lon, precision: 10, scale: 6
      t.string :name
      t.string :bio
      t.timestamps
    end
    add_index :users, [:lat, :lon]
  end
end
