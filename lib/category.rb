class Category

  attr_reader :name, :id, :total

  def initialize(attributes)
    @name = attributes[:name]
    @total = attributes[:total]
    @id = attributes[:id].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM category;")
    categories = []
    results.each do |result|
      category_hash = {}
      category_hash[:name] = result['name']
      category_hash[:id] = result['id'].to_i
      category_hash[:total] = result['total'].to_f
      categories << Category.new(category_hash)
    end
    categories
  end

 def self.total
    results = DB.exec("SELECT total FROM category;")
    final_total = 0.00
    results.each do |result|
      final_total += result['total'].to_f
    end
    final_total
  end

  def percentage_spent
    all_categories_total = Category.total
    category_total = self.total_spent
    results = category_total / all_categories_total
  end

  def update_total(cost)
    old_total = self.total_spent
    new_total = old_total + cost
    DB.exec("UPDATE category SET total = #{new_total} WHERE id = #{@id};")
    new_total
  end

  def ==(another_category)
    self.name == another_category.name
  end

  def save
    check = DB.exec("SELECT * FROM category WHERE name = '#{@name}';")
    if check.first == nil
      results = DB.exec("INSERT INTO category (name, total) VALUES ('#{@name}', #{@total}) RETURNING id;")
      @id = results.first['id'].to_i
    else
      @id = check.first['id']
    end
  end

  def total_spent
    results = DB.exec("SELECT total FROM category WHERE id = #{@id};")
    results.first['total'].to_f
  end

  def find_expense
    results = DB.exec("SELECT expense.* FROM category JOIN expense_type on (category.id = expense_type.category_id) JOIN expense on (expense.id = expense_type.expense_id) WHERE category.id = #{@id};")
  end
end
