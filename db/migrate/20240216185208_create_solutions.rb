class CreateSolutions < ActiveRecord::Migration[7.1]
  def change
    create_table :solutions do |t|
      t.string :user_email, null: false
      t.string :challenge_oid, null: false
      t.datetime :start_time, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :end_time
      t.string :answer
      t.boolean :answer_correct
      t.integer :new_elo
      t.integer :elo_change

      t.timestamps
    end
  end
end
