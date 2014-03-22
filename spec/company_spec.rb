require 'spec_helper'

describe Company do

  company = {:name => "nike"}

  it 'is initialized as an instance of company' do
    test_company = Company.new(company)
    test_company.should be_an_instance_of Company
  end

  it 'is initialized with a name' do
    test_company = Company.new(company)
    test_company.name.should eq "nike"
  end

    it 'is saved to the database table "expense"' do
      test_company = Company.new(company)
      test_company.save
      Company.all.should eq [test_company]
    end

    describe '.all' do
      it 'should be empty at first' do
        test_company = Company.new(company)
        Company.all.should eq []
      end
    end
    it 'is the same company if it has the same name and cost' do
      test_company1 = Company.new(company)
      test_company2 = Company.new(company)
      test_company1.should eq test_company2
    end

end
