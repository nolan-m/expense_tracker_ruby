require 'pg'
require 'rspec'
require 'catagory'
require 'expense'

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM expense")
    DB.exec("DELETE FROM catagory")
  end
end
