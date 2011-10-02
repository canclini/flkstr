Factory.define :company do |f|
  f.sequence(:name) { |n| "foobar #{n} GmbH" }
  f.association :plan
end

Factory.define :plan do |f|
  f.name  "scale"
#  f.cheddarcode "SCALE"
  f.tags 5
  f.leads 999
  f.requests 999
  f.notify true
end

Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "secret"
  f.association :company
end

Factory.define :request do |f|
  f.sequence(:name) { |n| "example request #{n}" }
  f.sequence(:description) { |n| "description of example request #{n}" }
  f.association :company
  # f.duedate
  # f.budget
  # f.area_filter
  # f.language
  # f.distance
  # association with leads?
end


Factory.define :lead do |f|
  f.association :request
  f.association :source, :factory => :company
  f.association :company
  f.status "new"
end