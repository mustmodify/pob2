module ApplicationHelper
  def page_title( value=nil )
    @page_title ||= value
  end

  def pad_options?
    page_title.not.blank?
  end

  def row_id_for( object )
    "#{object.class.name.tableize}_#{object.id}"
  end

  def tabular_atts( employee )
    atts = [:dob, :ssn, :nationality, :gsn, :transportation_needed, :body_weight, :bag_weight, :eligible_for_rehire]
    atts.map{|att| [att.to_s, employee.send(att)] }.
      reject{|x, y| y == nil || y == ''}.
      map do |name, value|
        if name == 'ssn' || name == 'dob' || name == 'gsn'
          name = name.upcase
        else
          name = name.titleize
        end

        if value === false
          [name, 'No']
        elsif value === true
          [name, 'Yes']
        else
          [name, value]
        end
      end
  end
end
