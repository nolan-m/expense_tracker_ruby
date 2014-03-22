require 'spec_helper'

describe Category do

  fast_food_hash = {:name => "Fast Food", :total => 10}
  exercise_hash = {:name => "Exercise", :total => 10}

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
  describe 'find_expense' do
    it 'finds expenses for inputted category' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.99, :date => "2014-03-07"})
      test_expense.save
      test_category = Category.new(fast_food_hash)
      test_category.save
      test_expense.expense_category_save(test_category.id)
      test_category.find_expense[0]['name'].should eq "Burger"
    end
  end
  describe 'total_spent' do
    it 'returns the total spent for that category' do
      test_expense = Expense.new({:name => "Burger", :cost => 5.99, :date => "2014-03-07"})
      test_expense.save
      test_category = Category.new(fast_food_hash)
      test_category.save
      test_expense.expense_category_save(test_category.id)
      test_expense2 = Expense.new({:name => "Fries", :cost => 1.99, :date => "2014-03-08"})
      test_expense2.save
      test_expense2.expense_category_save(test_category.id)
      test_category.total_spent.should eq 10
    end
  end

  describe 'total_spent' do
    it 'returns the total spent for that category' do
      test_category = Category.new(fast_food_hash)
      test_category2 = Category.new(exercise_hash)
      test_category.save
      test_category2.save
      Category.total.should eq 20.00
    end
  end
  describe 'percentage_spent' do
    it 'returns the percent spent on that category' do
      test_category = Category.new(fast_food_hash)
      test_category.save
      test_category2 = Category.new(exercise_hash)
      test_category2.save
      test_category.percentage_spent.should eq 0.5
    end
  end
  describe 'update_total' do
    it 'updates the total spent on the Category' do
      test_category = Category.new(fast_food_hash)
      test_category.save
      test_expense = Expense.new({:name => "Burger", :cost => 5.99, :date => "2014-03-07", :company_id => 1})
      test_category.update_total(test_expense.cost).should eq 15.99
      end
    end
end
