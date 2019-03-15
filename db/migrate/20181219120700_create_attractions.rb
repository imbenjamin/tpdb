class CreateAttractions < ActiveRecord::Migration[5.2]
    def change
        create_table :attractions, id: :uuid do |t|
            t.string :name
            t.string :slug, unique: true, null: false, index: true
            t.text :description
            t.date :opening_date
            t.date :closing_date

            t.float :top_speed
            t.float :height
            t.float :length
            t.integer :inversions
            t.integer :capacity

            t.references :location, foreign_key: true, type: :uuid
            t.references :area, foreign_key: true, type: :uuid
            t.references :attraction_type, foreign_key: true, type: :uuid

            t.timestamps
        end
    end
end