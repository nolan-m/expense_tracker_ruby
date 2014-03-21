class Expense

  attr_reader :name, :cost, :date, :id

  def initialize(attributes)
    @name = attributes[:name]
    @cost = attributes[:cost]
    @date = attributes[:date]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM expense;")
    expenses = []
    results.each do |result|
      expense_hash ={}
      expense_hash[:name] = result['name']
      expense_hash[:cost] = result['cost'].to_f
      expense_hash[:date] = result['date']
       expense_hash[:id] = result['id']
      expenses << Expense.new(expense_hash)
    end
    expenses
  end

  def ==(another_expense)
    self.name == another_expense.name && self.cost == another_expense.cost && self.date == another_expense.date
  end

  def save
    results = DB.exec("INSERT INTO expense (name, cost, date) VALUES ('#{@name}', #{@cost}, '#{@date}') RETURNING id;")
    @id = results.first['id'].to_i
  end
end
