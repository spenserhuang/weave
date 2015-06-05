class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.string :title
      t.text   :description
      t.string :event_street
      t.string :event_city
      t.string :event_state
      t.string :event_zip_code
      t.string :event_country
      t.string :event_type
      t.string :event_date_value
      t.time   :event_time_value

      t.timestamps

    end
  end
end
