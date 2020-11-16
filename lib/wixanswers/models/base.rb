
module WixAnswers
  module Models
    class Base
      attr_accessor :attrs

      def initialize(attrs={})
        self.attrs = attrs.deep_symbolize_keys!

        self.validate!
      end

      def validate!
        self.validate_schema!

        return self
      end

      def validate_schema!
        return unless defined?(self.class::SCHEMA)

        # make sure all required params appear and that the supplied arguments match their types
        self.class::SCHEMA.each_pair do |k,v|
          attr = self.attrs[k]

          raise WixAnswers::Exceptions::MissingAttribute.new(k) if v[:required] and attr.nil?

          attr_type = v[:type] == "Boolean" ? ["FalseClass", "TrueClass"] : Array.wrap(v[:type])

          raise WixAnswers::Exceptions::SchemaTypeError.new(v[:type], attr.class.name) if !attr.nil? and !attr_type.include?(attr.class.name)
        end
      end

      def method_missing(k)
        self.attrs[k.to_sym]
      end
    end
  end
end