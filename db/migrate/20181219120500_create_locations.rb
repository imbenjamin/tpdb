class CreateLocations < ActiveRecord::Migration[5.2]
    def change
        create_table :locations, id: :uuid do |t|
            t.string :name
            t.string :slug, unique: true, null: false, index: true
            t.text :description
            t.text :address
            t.float :latitude
            t.float :longitude
            t.string :city
            t.string :state
            t.string :country
            t.string :google_place_id

            t.references :parent, index: true, type: :uuid

            t.timestamps
        end
    end
end