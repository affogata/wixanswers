
module WixAnswers
  module Models
    class Label < Base
      SCHEMA ||= {
          id: {type: "String", description: "Ticket ID", required: true},
          name: {type: "String", required: true},
          status: {type: "Integer", required: true}
      }

      def initialize(attrs={})
        super(attrs)
      end
    end
  end
end