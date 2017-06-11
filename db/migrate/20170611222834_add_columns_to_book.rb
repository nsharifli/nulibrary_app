class AddColumnsToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :author, :string
    add_column :books, :description, :text
    add_column :books, :image, :text
  end
end
