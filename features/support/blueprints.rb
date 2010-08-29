require 'machinist/active_record'

Company.blueprint do
  name { Faker::Company.name }
end

User.blueprint do
  email { Faker::Internet.email}
  firstname { Faker::Name.first_name }
  lastname { Faker::Name.last_name }
  password  { "password" }
  password_confirmation { "password" }
end