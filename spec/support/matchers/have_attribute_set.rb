RSpec::Matchers.define :have_attribute_set do |attribute,value|
  match do |actual|
    actual.send(attribute).should == value
  end
end