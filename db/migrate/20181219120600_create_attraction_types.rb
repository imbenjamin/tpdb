class CreateAttractionTypes < ActiveRecord::Migration[5.2]
    def change
        create_table :attraction_types, id: :uuid do |t|
            t.string :name
            t.string :slug, unique: true, null: false
            t.text :description

            t.timestamps
        end
    end
end