namespace :mongo do
    desc 'Drop all collections from the MongoDB database'
    task drop: :environment do
        Mongoid.default_client.collections.each do |collection|
        collection.drop unless collection.name.include?('system.')
        end
    end
end