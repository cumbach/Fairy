class CreateHousekeepers < ActiveRecord::Migration
  def change
    create_table :housekeepers do |t|
      t.string :phone, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false

      t.timestamps null: false
    end
    add_index :housekeepers, :phone, unique: true
    add_index :housekeepers, :session_token, unique: true
  end
end
