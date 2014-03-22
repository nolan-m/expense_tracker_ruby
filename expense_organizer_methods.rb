def category_validator(name)
  results = DB.exec("select * from category where name  = '#{name}';")
  @categories = []
  results.each do |obj|
    @categories << obj['name']
  end
  @categories.length > 0
end
