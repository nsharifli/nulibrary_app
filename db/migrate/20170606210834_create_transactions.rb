class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.datetime :borrowed_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
