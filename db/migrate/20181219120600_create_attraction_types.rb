class CreateAttractionTypes < ActiveRecord::Migration[5.2]
    def change
        create_table :attraction_types, id: :uuid do |t|
            t.string :name
            t.string :slug, unique: true, null: false, index: true
            t.text :description

            t.timestamps
        end
    end
end