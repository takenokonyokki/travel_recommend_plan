module ApplicationHelper
  def errors_hash(resource)
      resource.errors.messages.map do |col, errors_array|
        [col, errors_array.map { |error| resource.class.human_attribute_name(col) + error }]
      end.to_h
  end
end