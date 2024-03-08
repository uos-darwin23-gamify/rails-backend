class CreateActivity < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.integer :group, null: false
      t.datetime :start_time, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :end_time
      t.integer :session_duration_seconds
      t.integer :elo_session_start, null: false
      t.integer :elo_session_end
      t.boolean :placement_challenges_finished_session_start, null: false
      t.boolean :placement_challenges_finished_session_end

      t.timestamps
    end
  end
end
