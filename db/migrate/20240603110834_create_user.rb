class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid  do |t|
      t.string :gender
      t.string :name
      t.jsonb :location
      t.integer :age

      t.timestamps
    end
  end
end

