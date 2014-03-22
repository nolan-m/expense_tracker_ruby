require 'pg'
require 'rspec'
require 'category'
require 'expense'
require 'company'

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM expense")
    DB.exec("DELETE FROM category")
    DB.exec("DELETE FROM expense_type")
    DB.exec("DELETE FROM companies")

  end
end
