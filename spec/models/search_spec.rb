require 'spec_helper'

describe Search do
  def finds_emp(atts)
    good_term = atts.delete(:works)
    target = FactoryGirl.create(:employee, atts)
    Search.new(term: good_term).results.should include( target ) if atts[:works]
  end
 
  it 'finds_emp by name' do
    finds_emp(first_name: 'Jim', works: 'ji')
    finds_emp(last_name: 'Henderson', works: 'hender')
  end

  it 'finds a project' do
    penny = FactoryGirl.create(:project, name: 'Go go Gadget')
    Search.new(term: 'gadget').results.should include(penny)
  end
end
