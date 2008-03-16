require File.dirname(__FILE__) + '/../spec_helper'

module ClientSpecHelper
  def valid_attr
    {
      :name => "WalMart",
      :address => "Av Dona Constanca, 1778",
      :contact => "Joao Silva",
      :phone => "82 9988-1122",
      :email => "joao@walmart.com",
      :city => cities(:maceio)
    }
  end
end

describe Client do
  include ClientSpecHelper
  
  fixtures :cities
  
  before(:each) do
    @client = Client.new
  end
  
  it "should have a name" do
    @client.attributes = valid_attr.except(:name)
    @client.should have(1).error_on(:name)
  end
  
  it "should have a name with less than 100 characters" do
    @client.attributes = valid_attr.except(:name)
    @client.name = ""
    101.times {@client.name << "a"}
    @client.should have(1).error_on(:name)
  end
  
  it "shoud have a city" do
    @client.attributes = valid_attr.except(:city)
    @client.should have(1).error_on(:city_id)
  end
  
  it "should be related to a city" do
    @client.city = cities(:maceio)
    @client.city.should eql(cities(:maceio))
    
  end
  
  it "should be valid" do
    @client.attributes = valid_attr
    @client.should be_valid
  end
end
