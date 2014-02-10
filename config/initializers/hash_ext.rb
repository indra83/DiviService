require 'active_support/core_ext/object/deep_dup'

class Hash
  def deep_transform_keys(&block)
    _deep_transform_keys_in_object!(self.deep_dup, &block)
  end

  def deep_transform_keys!(&block)
    _deep_transform_keys_in_object!(self, &block)
  end

private
  # Support method for deep transforming nested hashes and arrays
  # written by sakuro #10887
  def _deep_transform_keys_in_object!(object, &block)
    case object
    when Hash
      object.keys.each do |key|
        value = object.delete(key)
        object[yield(key)] = _deep_transform_keys_in_object!(value, &block)
      end
      object
    when Array
      object.map! {|e| _deep_transform_keys_in_object!(e, &block)}
    else
      object
    end
  end
end
