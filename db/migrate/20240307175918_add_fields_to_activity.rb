class AddFieldsToActivity < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :elo_difference, :integer
    add_column :activities, :league_session_start, :string
    add_column :activities, :league_position_session_start, :integer
    add_column :activities, :league_size_session_start, :integer
    add_column :activities, :league_session_end, :string
    add_column :activities, :league_position_session_end, :integer
    add_column :activities, :league_size_session_end, :integer
    add_column :activities, :global_position_session_start, :integer
    add_column :activities, :global_leaderboard_size_session_start, :integer
    add_column :activities, :global_position_session_end, :integer
    add_column :activities, :global_leaderboard_size_session_end, :integer
  end
end
