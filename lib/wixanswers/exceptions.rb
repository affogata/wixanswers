
module WixAnswers
  module Exceptions
    class UnsupportedType < StandardError
      def initialize(payload_type, value)
        super("Unsupported Payload #{payload_type.split('::')[-1]}: #{value}")
      end
    end

    class MissingAttribute < StandardError
      def initialize(value)
        super("Missing Attribute: #{value}")
      end
    end

    class SchemaTypeError < TypeError
      def initialize(expected, actual)
        super("no implicit conversation of #{expected} to #{actual}")
      end
    end

    class NotImplementedError < StandardError
      def initialize(object_type, value)
        super("Unimplemented #{object_type} Entity: #{value}")
      end
    end
  end
end