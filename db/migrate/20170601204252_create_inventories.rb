class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.integer :total_quantity
      t.integer :current_quantity
      t.belongs_to :book, foreign_key: true

      t.timestamps
    end
  end
end
