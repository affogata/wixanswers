

module WixAnswers
  module Enumerations
    class Enumeration
      def self.values
        Set.new(constants.map {|const| const_get(const) })
      end

      def self.valid?(value)
        values.include?(value)
      end

      def self.validate!(value)
        raise Exceptions::UnsupportedType.new(self.name, value) unless self.valid?(value)
      end
    end

    class WebhookType < Enumeration
      TICKET_CREATED ||= 2
      TICKET_STATUS_CHANGED ||= 8
    end

    class AttachmentStatus < Enumeration
      FAILED ||= 1
      INVALID_EXTENSION ||= 2
      MAX_FILE_SIZE_EXCEEDED ||= 3
      OK ||= 200
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#user-type
    class UserType < Enumeration
      AUTHENTICATED ||= 1
      UNAUTHENTICATED ||= 2
      PENDING_AUTHENTICATION ||= 4
      PENDING_DELETION ||= 5
      DELETED ||= 99
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#call-type
    class CallType < Enumeration
      INBOUND ||= 10
      OUTBOUND ||= 20
      CALLBACK ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#reply-type
    class ReplyType < Enumeration
      USER ||= 100
      CC_USER ||= 101
      AGENT ||= 110
      INTERNAL ||= 120
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#article-type
    class ArticleType < Enumeration
      ARTICLE ||= 100
      FEATURE_REQUEST ||= 110
      KNOWN_ISSUE ||= 120
      VIDEO ||= 130
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#ticket-priority
    class TicketPriority < Enumeration
      LOW ||= 10
      NORMAL ||= 20
      HIGH ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#channel
    class Channel < Enumeration
      WEB ||= 100
      EMAIL ||= 110
      PHONE_CALLBACK ||= 120
      PHONE_OUTBOUND ||= 121
      PHONE_INBOUND ||= 122
      BY_AGENT ||= 130
      FACEBOOK ||= 140
      WHATSAPP ||= 150
      CHAT ||= 160
      WIDGET ||= 170
      API ||= 180
      SMS ||= 190
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#satisfaction
    class Satisfaction < Enumeration
      NOT_AT_ALL ||= 10
      NOT_VERY ||= 10
      SOMEWHAT ||= 20
      VERY ||= 30
      EXTREMELY ||= 40
    end
  end
end