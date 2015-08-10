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
end
