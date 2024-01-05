class CreateSqlPlaceholder < ActiveRecord::Migration[7.1]
  def change
    create_table :sql_placeholder do |t|
      t.string :name

      t.timestamps
    end

    add_index :sql_placeholder, :name, unique: true
  end
end
