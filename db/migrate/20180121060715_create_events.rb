class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :location
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end

    add_attachment :events, :main_image
  end
end
