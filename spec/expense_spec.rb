require 'spec_helper'

describe Expense do

  burger_hash = {:name => "Burger", :cost => 5.99, :date => "2014-03-07", :company_id => 1}

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

  describe 'expense_category_save' do
    it 'saves the expense_id and category_id to a join table' do
      test_expense = Expense.new(burger_hash)
      test_expense.save
      test_category = Category.new({:name => 'Fast Food', :total => 0})
      test_category.save
      test_expense.expense_category_save(test_category.id)
      DB.exec("SELECT * FROM expense_type;").first['expense_id'].to_i.should eq test_expense.id
    end
  end

  # describe 'find_category' do
  #   it'returns category of inputted item' do
  #     test_expense = Expense.new(burger_hash)
  #     test_expense.save
  #     test_category = Category.new({:name => 'Fast Food'})
  #     test_category.save
  #     test_expense.expense_category_save(test_category.id)
  #     test_expense.find_category("Burger").first.should eq 'Fast Food'
  #   end
  # end
end
