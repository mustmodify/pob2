Employee.destroy_all

require 'open-uri'

4.times.each do |index|
  page = index + 1

  json = JSON.parse(File.read("db/emp#{page}.json"))
  out = []
  
  json['data'].first.each do |emp|
    out_emp = {}
  
    emp['data'].each do |key, value|
      if key =~ /employees___(.*)_raw/
        out_emp[$1] = value
      end
    end
  
    out << out_emp
  end
  
  out.each do |emp_data|
    Employee.create(
      first_name: emp_data['first_name'],
      middle_name: emp_data['middle_initial'],
      last_name: emp_data['last_name'],
      home_phone: emp_data['home_phone_number'],
      cell_phone: emp_data['cell_phone_number'],
      alt_phone: emp_data['alt_phone_number'],
      picture: open("http://pob.redballtechnology.com/#{emp_data['photo']}")
    )
  end
end
