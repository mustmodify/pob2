placeholder = Position.find_by_name('Placeholder') || Position.create(name: 'Placeholder')

Assignment.destroy_all

@list = {}
Project.all.each do |p|
  @list["#{p.client} #{p.name}"] = p
  @list["#{p.name} #{p.client}"] = p
  @list["TDS #{p.name}"] = p if p.client == 'Triton'
  @list[p.name] = p
end

@bad = []
Employee.all.each do |emp|
  puts "="
  @list.keys.each do |key|
    puts " ===="
    if emp.alerts && emp.alerts.downcase.index(key.downcase)
      project = @list[key]
      pos = nil

      if( emp.competencies.count == 1 )
	pos = emp.competencies.first.position
      end
puts "."
      Assignment.create!(employee: emp, project: project, position: pos || placeholder)
      emp.alerts.gsub!(/#{key}/i, '')
      emp.save
    end
  end
end
