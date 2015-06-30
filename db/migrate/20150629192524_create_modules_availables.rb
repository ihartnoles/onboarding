class CreateModulesAvailables < ActiveRecord::Migration
  def change
    create_table :modules_availables do |t|
      t.string :znumber
      t.string :netid
      t.integer :welcome
      t.integer :deposit
      t.integer :account
      t.integer :communication
      t.integer :immunization
      t.integer :finaid
      t.integer :housingfee
      t.integer :residency
      t.integer :housingmealplan
      t.integer :aleks
      t.integer :oars
      t.integer :learning_comm
      t.integer :orientation
      t.integer :registration
      t.integer :emergency
      t.integer :faualert
      t.integer :owlcard
      t.integer :bookadvance
      t.integer :tution
      t.integer :vehiclereg

      t.timestamps
    end
  end
end
