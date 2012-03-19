# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  m = Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  end
# Given /^I check the following ratings:(.*)/ do |ratings|
#   ratings.split(", ").each do |rating|
#   steps %Q{
#   When I check "ratings_#{rating}"
#   }
#   end
# end

Then /^I should see all the movies/ do ||
  db_rows = Movie.count
  rows = find("table#movies tbody").all('tr').size
  assert db_rows == rows, "Wrong number of rows"
end

Then /^I should see no movies/ do ||
  db_rows = Movie.count
  rows = find("table#movies tbody").all('tr').size
  assert 0 == rows, "Wrong number of rows"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  body = page.body
  assert body =~ /.*(#{e1}).*(#{e2})/im, "Order is not correct"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
  steps %Q{
  When I #{uncheck}check "ratings_#{rating}"
  }
  end
end
