class AddUserBookReferenceToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :user, foreign_key: true
    add_reference :transactions, :book, foreign_key: true
  end
end
