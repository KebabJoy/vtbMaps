class CreateAtms < ActiveRecord::Migration[7.0]
  def change
    create_table :atms do |t|
      t.boolean :allday, default: false, comment: "Круглосуточно"
      t.jsonb :services, null: false, default: {}, comment: "Доступность отделения"
      t.timestamps
    end
  end
end
