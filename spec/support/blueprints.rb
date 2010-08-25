require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

require 'machinist/active_record'

Company.blueprint do
  name
end

User.blueprint do
  name
  email
end