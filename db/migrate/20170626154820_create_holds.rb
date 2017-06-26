class CreateHolds < ActiveRecord::Migration[5.0]
  def change
    create_table :holds do |t|
      t.datetime :requested_at
      t.datetime :closed_at
      t.datetime :sent_email
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
