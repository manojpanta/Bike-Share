class CreateAccessoryOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :accessory_orders do |t|
      t.integer :quantity, default: 1
      t.references :order, foreign_key: true
      t.references :accessory, foreign_key: true

      t.timestamps
    end
  end
end
