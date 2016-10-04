class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :address, null: false
      t.datetime :scheduled_at, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :housekeeper_id, index: true

      t.timestamps null: false
    end
  end
end
