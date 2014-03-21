require 'pg'
require './lib/expense'
require './lib/catagory'

DB = PG.connect({:dbname => 'expense_organizer'})


def main_menu
  puts "Expense Organizer"
  puts "-----------------"
  puts "Press 'A' to add an expense"
  puts "Press 'D' to view expense details"
  puts "Press 'X' to leave Expense Organizer"

  case gets.chomp.upcase
    when 'A'
      add_expense
    when 'D'
      list_menu
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

  new_expense = Expense.new(expense_hash)
  new_expense.save

  puts "#{new_expense.name} added to database."
  main_menu
end


def list_menu
  puts "Expense Details Menu"
  puts "---------------------"
  puts "Press 'L' to list all of your expenses"
  puts "Press 'M' to return to main menu"

  case gets.chomp.upcase
   when "L"
    all_expenses
    main_menu
  when "M"
    main_menu
  else
    puts "Invalid input"
    list_menu
  end
end

def all_expenses
  puts "All of your expenses;"
  Expense.all.each_with_index do |expense, index|
    puts "#{index + 1}) #{expense.name} Cost: #{expense.cost} made on #{expense.date}"
  end
end

main_menu
