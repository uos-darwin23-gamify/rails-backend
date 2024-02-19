# frozen_string_literal: true

class PreAuthorizedEmail < ApplicationRecord
  self.table_name = "pre_authorized_emails"

  enum group: {league: 0, global: 1, admin_group: 99}
  validates :group, presence: true, inclusion: {in: PreAuthorizedEmail.groups.keys}
end
