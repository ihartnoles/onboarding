class AddIsactiveToFticModulesAvailables < ActiveRecord::Migration
  def change
    add_column :ftic_modules_availables, :isactive, :integer
  end
end
