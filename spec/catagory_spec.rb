require 'spec_helper'

describe Category do

  fast_food_hash = {:name => "Fast Food"}

  it 'initializes as an instance of Category' do
    test_category = Category.new(fast_food_hash)
    test_category.should be_an_instance_of Category
  end
  it 'initializes with a name' do
    test_category = Category.new(fast_food_hash)
    test_category.name.should eq 'Fast Food'
  end
  describe 'save' do
    it 'saves a catagory to the database' do
      test_category = Category.new(fast_food_hash)
      test_category.save
      Category.all.should eq [test_category]
    end
  end
end
