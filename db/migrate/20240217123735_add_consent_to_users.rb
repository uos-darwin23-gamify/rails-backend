class AddConsentToUsers < ActiveRecord::Migration[7.1]
    def change
      add_column :users, :consent, :boolean, default: false
    end
  end
  