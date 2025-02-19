# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts ">>>> Running initial seed."

if User.admin.count.zero?
  User.create(email_address: "admin@homeyproject.com", password: "base8848", role: User.roles[:admin])
end

if User.manager.count != 3
  User.create(email_address: "manager1@homeyproject.com", password: "base8848", role: User.roles[:manager])
  User.create(email_address: "manager2@homeyproject.com", password: "base8848", role: User.roles[:manager])
  User.create(email_address: "manager3@homeyproject.com", password: "base8848", role: User.roles[:manager])
end

if User.member.count != 10
  User.create(email_address: "member1@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member2@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member3@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member4@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member5@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member6@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member7@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member8@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member9@homeyproject.com", password: "base8848", role: User.roles[:member])
  User.create(email_address: "member10@homeyproject.com", password: "base8848", role: User.roles[:member])
end

if Project.count.zero?
  Project.create(name: "First Homey Project", description: "A sample project.", status: Project.statuses[:todo], manager_user_id: User.manager.first.id)
  ProjectUser.create(project_id: Project.first.id, user_id: User.member.first.id)
end
