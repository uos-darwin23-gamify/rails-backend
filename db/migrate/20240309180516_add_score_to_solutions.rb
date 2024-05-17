class AddScoreToSolutions < ActiveRecord::Migration[7.1]
  def change
    add_column :solutions, :score, :decimal
  end
end
