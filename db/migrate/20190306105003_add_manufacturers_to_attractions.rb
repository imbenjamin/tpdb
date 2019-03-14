class AddManufacturersToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_reference :attractions, :manufacturer, type: :uuid, foreign_key: true
  end
end
