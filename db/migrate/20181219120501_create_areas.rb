class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas, id: :uuid do |t|
      t.string :name
      t.string :slug, unique: true, null: false, index: true
      t.text :description

      t.belongs_to :location, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
