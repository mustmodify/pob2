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
    employee.attributes.slice('dob', 'ssn', 'nationality', 'gsn', 'transportation_needed', 'body_weight', 'bag_weight', 'eligible_for_rehire').reject{|x, y| y == nil || y == ''}.map{|x, y| y === false ? [x.titleize, 'No'] : [x.titleize, y]}
  end
end
