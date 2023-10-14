class AddLoadValueToBankOffices < ActiveRecord::Migration[7.0]
  def change
    add_column :bank_offices, :load_value, :integer, default: 0
  end
end
