class CreatePreAuthorizedEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :pre_authorized_emails do |t|
      t.string :email, null: false

      t.timestamps
    end

    add_index :pre_authorized_emails, "LOWER(email)", unique: true
  end
end
