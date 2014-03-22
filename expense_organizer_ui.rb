require 'pg'
require './lib/expense'
require './lib/category'
require './lib/company'
require './expense_organizer_methods'
require 'pry'

DB = PG.connect({:dbname => 'expense_organizer'})


def main_menu
  puts "Expense Organizer"
  puts "-----------------"
  puts "Press 'A' to add an expense"
  puts "Press 'V' to view expense details"
  puts "Press 'P' to see your percent purchase for a category"
  puts "Press 'X' to leave Expense Organizer"

  case gets.chomp.upcase
    when 'A'
      add_expense
    when 'V'
      list_menu
    when 'P'
      category_percent
    when 'X'
      "Goodbye."
    else
      puts "Invalid input."
      main_menu
    end
end

def add_expense
  expense_hash = {}
  puts "Enter expense description:"
  expense_hash[:name] = gets.chomp
  puts "Enter expense cost:"
  expense_hash[:cost] = gets.chomp.to_f
  puts "Enter expense date (YYYY-MM-DD):"
  expense_hash[:date] = gets.chomp
  puts "Where did you buy this from?"
  company = gets.chomp
  new_company = Company.new({:name => company})
  new_company.save
  expense_hash[:company_id] = new_company.id
  puts "Enter the purchase category:"
  category = gets.chomp
  new_category = Category.new({:name => category, :total => 0.0})
  new_category.save
  new_expense = Expense.new(expense_hash)
  new_expense.save
  new_expense.expense_category_save(new_category.id)
  new_category.update_total(new_expense.cost)

  puts "#{new_expense.name} added to database."
  main_menu
end

def list_menu
  puts "Expense Details Menu"
  puts "---------------------"
  puts "Press 'L' to list all of your expenses"
  puts "Press 'C' to list expenses by category"
  puts "Press '%' to see the percentage spent per category"
  puts "Press 'M' to return to main menu"

  case gets.chomp.upcase
   when "L"
    all_expenses
    main_menu
  when "M"
    main_menu
  when "C"
    expenses_by_category
    main_menu
  when "%"
    category_percentage
    main_menu
  else
    puts "Invalid input"
    list_menu
  end
end

def expenses_by_category
  list_categories
  puts "Enter the number to view expenses for that category"
  current_category = Category.all[gets.chomp.to_i - 1]
  results = current_category.find_expense

  results.each_with_index do |result, index|
    puts "#{index + 1}) #{result['name']} - Cost: #{result['cost']} - Date: #{result['date']}"
  end
end

def category_percentage
  list_categories
  puts "Enter the number to view percentage spent on that category"
  current_category = Category.all[gets.chomp.to_i - 1]
  puts "You have spent #{current_category.percentage_spent.round(2) * 100}% on #{current_category.name}"
end

def all_expenses
  puts "All of your expenses;"
  Expense.all.each_with_index do |expense, index|
    puts "#{index + 1}). #{expense.name} Cost: #{expense.cost} made on #{expense.date}"
  end
end

def list_categories
  puts "Current Categories"
  Category.all.each_with_index do |category, index|
    puts "#{index + 1}. #{category.name} Total Spent: #{category.total}"
  end
end


main_menu
