# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

require_relative 'challenges'
require_relative 'placement_challenges'
require_relative 'codeOutputChallenge'
require_relative 'connectBlocksChallenge'
require_relative 'mcqChallenges'
require_relative 'scqChallenges'

# Active Record syntax
PreAuthorizedEmail.find_or_create_by!(:email => "admin@test.com", group: PreAuthorizedEmail.groups["admin_group"])

