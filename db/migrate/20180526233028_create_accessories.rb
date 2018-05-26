class CreateAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :accessories do |t|
      t.string :title
      t.string :image
      t.decimal :price
      t.boolean :is_retired?, default: false
      t.string :description

      t.timestamps
    end
  end
end
