# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if Rails.env.test? || Rails.env.development?
  Yapos::Application.config.secret_token = '1ea7d01bcdb0b77b9c6333249094c39923dd73e6775e84d462dffc9b2fbac63be7d90c5be44ee76db3736925581dc0dbbd3febbcda8f4c1a94b9eb9bf672e48a'
else
  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if ENV['SECRET_TOKEN'].blank?
  Yapos::Application.config.secret_token = ENV['SECRET_TOKEN']
end
