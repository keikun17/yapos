# If you enfcounter errors with Capybara-webkit, read :
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
include Warden::Test::Helpers
Warden.test_mode!

def logged_as_default_user
  user = create(:user)
  login_as(user, scope: :user)
end
