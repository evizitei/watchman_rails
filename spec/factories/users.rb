Factory.define :user do |u|
  u.email "email@example.com"
  u.password "foobar"
  u.password_confirmation "foobar"
  u.phone "15731234567"
  u.organization_id "AB1234"
end