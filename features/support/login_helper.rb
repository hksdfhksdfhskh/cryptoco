module LoginHelper
  include Warden::Test::Helpers

   def login(user)
    login_as(user)
  end

   def logout
    super
    page.driver.browser.clear_cookies # clear remember me cookies (if any)
  end
end

World(LoginHelper)
