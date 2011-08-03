Factory.define :company do |f|
  f.sequence(:name) { |n| "foobar #{n} GmbH" }
end

Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "secret"
  f.association :company
  #f.sequence(:auth_token) { |n| "asdkj#{n}" }
end