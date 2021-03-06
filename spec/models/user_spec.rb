require 'spec_helper'

describe User do
  it { should allow_value("15732395840").for(:phone) }
  it { should_not allow_value("test").for(:phone) }
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:organization_id)}

  describe "phone attribute" do
    it "should strip dashes" do
      User.new(:phone=>"1-573-239-5840").phone.should == "15732395840"
    end

    it "strips parens" do
      User.new(:phone=>"1(573)2395840").phone.should == "15732395840"
    end

    it "removes whitespace from either side" do
      User.new(:phone=>"  15732395840  ").phone.should == "15732395840"
    end

    it "strips whitespace from within" do
      User.new(:phone=>"1 573 239 5840").phone.should == "15732395840"
    end

    it "adds country from within" do
      User.new(:phone=>"573 239 5840").phone.should == "15732395840"
    end

    it "reformats a common phone format" do
      User.new(:phone=>"1 (573) 239-5840 ").phone.should == "15732395840"
    end
  end

  describe "organization_id" do
    before(:each) do
      OrganizationId.delete_all
      @user = FactoryGirl.build(:user,:organization_id=>"AB1234")
    end

    it "must have one from the table to create" do
      @user.save.should == false
      @user.errors.full_messages.should include("you must have an active organization id")
    end

    it "can create if the organization id is there" do
      OrganizationId.create!(:name=>"AB1234")
      @user.save.should == true
    end
  end

  describe "subscriptions" do
    before(:each) do
      OrganizationId.create!(:name=>"AB1234")
      @user = FactoryGirl.create(:user)
    end

    it "defaults to empty" do
      @user.subscriptions.should be_empty
    end

    it "can be added to" do
      @user.add_subscription!("E1401")
      @user.subscriptions.should == ["E1401"]
    end

    describe "persisting to DB" do
      before(:each) do
        @user.add_subscription!("E1401")
        @user.add_subscription!("E801")
        @user.add_subscription!("E901")
      end

      subject{ @user.reload.subscriptions }
      it{ should include("E1401")}
      it{ should include("E801")}
      it{ should include("E901")}
    end

    describe "checking subscription" do
      before(:each) do
        @user.add_subscription!("E1401")
        @user.add_subscription!("E801")
        @user.add_subscription!("E901")
      end

      it "should return true if theres a match" do
        @user.is_subscribed_to?(["E601","E1401","G806"]).should == true
      end

      it "should return false if theres not a match" do
        @user.is_subscribed_to?(["E601","G906","G806"]).should == false
      end

      describe "day subscriptions" do
        before do
          @user.add_day_subscription!("E1501")
          @user.add_day_subscription!("E601")
          @user.add_day_subscription!("G606")
        end

        it "matches during the day" do
          Timecop.freeze(2011, 7, 28, 14)
          @user.is_subscribed_to?(["E601","E1501","G606"]).should == true
          Timecop.return
        end

        it "doesn't match at night" do
          Timecop.freeze(2011, 7, 28, 2)
          @user.is_subscribed_to?(["E601","E1501","G606"]).should == false
          Timecop.return
        end

        it "can have subscriptions removed" do
          @user.remove_day_subscription!("E1501")
          @user.reload.day_subscriptions.size.should == 2
        end
      end
    end
  end
end
