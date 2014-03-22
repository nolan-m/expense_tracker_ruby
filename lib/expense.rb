class Expense

  attr_reader :name, :cost, :date, :id, :company_id

  def initialize(attributes)
    @name = attributes[:name]
    @cost = attributes[:cost]
    @date = attributes[:date]
    @company_id = attributes[:company_id].to_i
    @id = attributes[:id].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM expense;")
    expenses = []
    results.each do |result|
      expense_hash ={}
      expense_hash[:name] = result['name']
      expense_hash[:cost] = result['cost'].to_f
      expense_hash[:date] = result['date']
      expense_hash[:company_id] = result['company_id']
      expense_hash[:id] = result['id']
      expenses << Expense.new(expense_hash)
    end
    expenses
  end

  def ==(another_expense)
    self.name == another_expense.name && self.cost == another_expense.cost && self.date == another_expense.date && self.company_id == another_expense.company_id
  end

  def save
    results = DB.exec("INSERT INTO expense (name, cost, date, company_id) VALUES ('#{@name}', #{@cost}, '#{@date}', #{@company_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

   def expense_category_save(category_id)
    DB.exec("INSERT INTO expense_type (expense_id, category_id) VALUES (#{@id}, #{category_id});")
  end

  def find_category

  end
end
