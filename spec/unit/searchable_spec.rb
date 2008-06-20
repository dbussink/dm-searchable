require 'pathname'
require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'

describe "DataMapper::Searchable" do

  class Cow
    include DataMapper::Resource
    include DataMapper::Searchable

    property :id,        Serial
    property :name,      String
    property :breed,     String

    is_searchable

    auto_migrate!(:default)
  end

  it "is included when DataMapper::Searchable is loaded" do
    Cow.new.should be_kind_of(DataMapper::Searchable)
  end

  it "adds the search method for a DataMapper::Searchable object" do
    c = Cow.new
    c.class.should respond_to(:search)
  end

  it "should define all fields searchable except for keys when no fields are given" do
    Cow.instance_variable_get("@searchable_fields").should_not be_nil
    Cow.instance_variable_get("@searchable_fields").should_not include(:id)
    Cow.instance_variable_get("@searchable_fields").should     include(:name)
    Cow.instance_variable_get("@searchable_fields").should     include(:breed)
  end

  it "should define the correct fields searchable if fields are given" do
    class Cow
      is_searchable(:name)
    end

    Cow.instance_variable_get("@searchable_fields").should_not be_nil
    Cow.instance_variable_get("@searchable_fields").should_not include(:id)
    Cow.instance_variable_get("@searchable_fields").should     include(:name)
    Cow.instance_variable_get("@searchable_fields").should_not include(:breed)
  end

  it "should be able to search for certain objects and find them correctly" do
    c1 = Cow.create(:name => "Bertha")
    c2 = Cow.create(:name => "Clara")
    
    cows = Cow.search("rth a")
    cows.length.should == 1
    cows.should     include(c1)
    cows.should_not include(c2)

    cows = Cow.search("a")
    cows.length.should == 2
    cows.should     include(c1)
    cows.should     include(c2)

    cows = Cow.search("x")
    cows.length.should == 0
    cows.should_not include(c1)
    cows.should_not include(c2)
  end

end
