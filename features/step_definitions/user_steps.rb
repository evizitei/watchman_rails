
When /^I cancel my subscription$/ do
  visit "/"
  click_button "Remove"
end

When /^I subscribe to E1401$/ do
  first(:select, 'apparatus').first(:option, 'E1401').select_option
  first(:button, 'subscribe').click
end
