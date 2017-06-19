class ChangeColumnNameInBookModel < ActiveRecord::Migration[5.0]
  def change
    rename_column :books, :ibn, :isbn
  end
end
