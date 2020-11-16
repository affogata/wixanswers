require_relative './base'

# https://help.wixanswers.com/kb/en/article/api-object-structures#attachment-object
module WixAnswers
  module Models
    class Attachment < Base
      SCHEMA ||= {
          name: {type: "String", description: "The attachment name", required: true},
          url: {type: "String", description: "URL of the attachment", required: true},
          status: {type: "Integer", description: "The attachment status", required: true},
          sizeBytes: {type: "Integer", description: "The size of the attachment, in bytes"},
          contentType: {type: "String", description: "The content type of the attachment"}
      }

      def initialize(attrs={})
        super(attrs)
      end
    end
  end
end