# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create(email_address: "admin@homeyproject.com", password: "base8848", role: User.roles[:admin])
User.create(email_address: "manager@homeyproject.com", password: "base8848", role: User.roles[:manager])
User.create(email_address: "member@homeyproject.com", password: "base8848", role: User.roles[:member])
