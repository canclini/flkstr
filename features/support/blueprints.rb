require 'machinist/active_record'

Company.blueprint do
  name { Faker::Company.name }
end