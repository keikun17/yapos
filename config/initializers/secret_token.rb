# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.


#TODO : USE config/secrets.yml
if Rails.env.test? || Rails.env.development?
  Devise.secret_key = 'd78a3c08cbd5ef8431c4fd6d5e321524c2f7ee055ef6a072e912a2f5cff88e6bce4f3612a34f325b24698fec510bf34638bd5c8fbaf6a736bb352e4621ae0560'  # For Devise
  Yapos::Application.config.secret_token = '1ea7d01bcdb0b77b9c6333249094c39923dd73e6775e84d462dffc9b2fbac63be7d90c5be44ee76db3736925581dc0dbbd3febbcda8f4c1a94b9eb9bf672e48a' # For Rails
else
  raise "You must set a devises secret key in ENV['DEVISE_SECRET_KEY'] or in config/initializers/secret_token.rb" if ENV['DEVISE_SECRET_KEY'].blank?
  Devise.secret_key = ENV['DEVISE_SECRET_KEY']  # FOR DEVISE
  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if ENV['SECRET_TOKEN'].blank?
  Yapos::Application.config.secret_token = ENV['SECRET_TOKEN'] # For Rails
end
