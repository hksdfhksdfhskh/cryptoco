STANDARD_EMAIL = 'me@example.com'

Given("I am a logged in user") do
  @user = create(:user, email: STANDARD_EMAIL)
  login(@user)
end

Given("I am not logged in") do
  logout
end

When(/^(?:|I )visit ([^"]*)$/) do |path|
  visit path_to(path)

  step 'have no javascript error'
end

Then(/^(?:|I )should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^(?:|I )should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_content(text)
end

Then 'have no javascript error' do
  next unless @tags.include? '@javascript'

   aggregate_failures 'javascript errors' do
    errors = page.driver.browser.manage.logs.get(:browser)

     errors.each do |error|
      # ignore non-200 error response log
      next if error.message =~ /Failed to load resource:/

       expect(error.level).not_to eq('SEVERE'), "JS ERROR: #{error.message}"

       next unless error.level == 'WARNING'

       STDERR.puts 'JS WARN:'
      STDERR.puts error.message
    end
  end
end

Then(/^(?:|I )should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path

   if page_name.starts_with?('"') || page_name.starts_with?("'")
    rel_url = page_name.tr("'\"", '')
    expect(current_path).to eq(rel_url)
  else
    path = path_to(page_name)
    path.is_a?(String) ?
      expect(current_path).to(eql(path_to(path))) :
      expect(current_path).to(match(path))
  end
end

def path_to(page_name)
  case page_name
  when "coins page" then coins_path
  when "log in page" then new_user_session_path
  else page_name
  end
end
