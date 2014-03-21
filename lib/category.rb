class Category

  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM category;")
    categories = []
    results.each do |result|
      category_hash = {}
      category_hash[:name] = result['name']
      category_hash[:id] = result['id']
      categories << Category.new(category_hash)
    end
    categories
  end

  def ==(another_category)
    self.name == another_category.name
  end

  def save
    results = DB.exec("INSERT INTO category (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end
end
