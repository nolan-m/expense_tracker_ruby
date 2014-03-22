require 'pg'

class Company

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM companies;")
    companies = []
    results.each do |result|
      company_hash ={}
      company_hash[:name] = result['name']
      companies << Company.new(company_hash)
    end
    companies
  end

  def ==(another_company)
    self.name == another_company.name
  end

  def save
    results = DB.exec("INSERT INTO companies (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

#    def expense_category_save(category_id)
#     DB.exec("INSERT INTO expense_type (expense_id, category_id) VALUES (#{@id}, #{category_id});")
#   end

#   def find_category(name)
#       categories = []
#       results = DB.exec("SELECT category.* from
#         expense_type join expense on (expense.id = expense_type.expense_id)
#                      join category on (category.id = expense_type.category_id)
#         where expense.name = '#{name}';")
#       results.each do |result|
#         categories << result['name']
#       end
#       categories
#     end
end
