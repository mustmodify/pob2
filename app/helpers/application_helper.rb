module ApplicationHelper
  def page_title( value=nil )
    (@page_title ||= value)
  end

  def pad_options?
    page_title.not.blank?
  end

  def status_label(object, options = {})
    "<span class='label #{class_for_status_label(object.status)} #{options[:class]}'>#{object.status}</span>".html_safe
  end

  def class_for_status_label( status )
    case status
    when 'Active'
      'label-success'
    when 'Disabled'
      'label-inverse'
    else
      'label-info'
    end
  end

  def row_id_for( object )
    "#{object.class.name.tableize}_#{object.id}"
  end

  def tabular_atts( employee )
    atts = [:dob, :ssn, :nationality, :gsn, :body_weight, :bag_weight, :eligible_for_rehire]
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

  def selectable_employees
    (Employee.active.alphabetical + [nil] + Employee.terminated.alphabetical).map{|e| e ? [e.name, e.id] : [nil, nil]}
  end

  def missing_customary_cert_names
    required_cert_name_ids = CustomaryCert.where(position_id: @employee.position_ids).pluck(:cert_name_id).uniq
    missing_cert_name_ids = (required_cert_name_ids - @certs.map(&:cert_name_id))
    CertName.where(id: missing_cert_name_ids)
  end
end
