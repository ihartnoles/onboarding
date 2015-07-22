class CreateHousingZipcodes < ActiveRecord::Migration
  def change
    create_table :housing_zipcodes do |t|
      t.integer :zip
      t.text :city
      t.text :state
      t.text :county
      t.text :campus
      t.float :distance

      t.timestamps
    end
  end
end
