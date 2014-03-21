require 'spec_helper'

describe Expense do

  burger_hash = {:name => "Burger", :cost => 5.99, :date => "2014-03-07"}

  it 'is initialized as an instance of Expense' do
    test_expense = Expense.new(burger_hash)
    test_expense.should be_an_instance_of Expense
  end

  it 'is initialized with a name and cost' do
    test_expense = Expense.new(burger_hash)
    test_expense.name.should eq "Burger"
    test_expense.cost.should eq 5.99
    test_expense.date.should eq '2014-03-07'
  end

  describe 'save' do
    it 'is saved to the database table "expense"' do
      test_expense = Expense.new(burger_hash)
      test_expense.save
      Expense.all.should eq [test_expense]
    end
  end

  describe '==' do
    it 'is the same expense if it has the same name and cost' do
      test_expense1 = Expense.new(burger_hash)
      test_expense2 = Expense.new(burger_hash)
      test_expense1.should eq test_expense2
    end
  end
end
