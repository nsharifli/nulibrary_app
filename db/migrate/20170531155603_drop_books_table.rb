class DropBooksTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :books
  end
end
