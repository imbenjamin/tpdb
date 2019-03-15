class CreateManufacturers < ActiveRecord::Migration[5.2]
  def change
    create_table :manufacturers, id: :uuid do |t|
      t.string :name
      t.string :slug, unique: true, null: false, index: true
      t.string :description
      t.string :website


      t.timestamps
    end
  end
end
