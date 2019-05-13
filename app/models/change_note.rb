class ChangeNote < Valuable
  has_value :obj
  has_value :field, :klass => :string
  has_value :old_value
  has_value :new_value

  def self.for( instance, options = {} )
    black_list = [options[:ignore]].flatten.map(&:to_s)

    instance.changes.map do |field, (old_val, new_val)|
      if black_list.include?( field )
        # skip
      elsif [old_val, new_val].compact == [""]
        # also skip
      else
        new( field: field, old_value: old_val, new_value: new_val, obj: instance )
      end
    end.compact
  end

  def association
    @association ||= obj.class.reflect_on_all_associations.detect{|ass| ass.foreign_key == field }
  end

  def fk?
    field =~ /_id$/
  end

  def known_foreign_key?
    fk? && association
  end

  def handle_associations
    if known_foreign_key?
      self.field = association.name.to_s.humanize

      self.old_value = association.klass.find( old_value ).to_s if old_value
      self.new_value = association.klass.find( new_value ).to_s if new_value
    elsif fk?
      Rollbar.error("Could not figure out what to do with #{obj.class.name} #{obj.id} when #{field} changed from #{old_value} to #{new_value}")
    end
  end

  def handle_durations
    if field == 'estimated_time'
      self.old_value = self.old_value.to_duration if self.old_value
      self.new_value = self.new_value.to_duration if self.new_value
    elsif field == 'call_ahead'
      self.old_value = self.old_value.to_duration if self.old_value
    end
  end

  def to_s
    handle_associations
    handle_durations

    if old_value.is_a?(TrueClass) || old_value.is_a?(FalseClass)
      %|Changed #{field.humanize} from #{old_value ? 'yes' : 'no'} to #{new_value ? 'yes' : 'no'}|
    elsif old_value.blank?
      %|Added #{field.humanize}: "#{new_value}"|
    elsif new_value.blank?
      %|Removed #{field.humanize}. (previously "#{old_value}")|
    else
      %|#{field.titleize} changed from "#{old_value}" to "#{new_value}"|
    end
  end
end
