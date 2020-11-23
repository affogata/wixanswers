

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

      def self.by_values
        constants.map {|const| [const_get(const), const] }.to_h
      end

      def self.title(value)
        const_name = self.by_values[value]
        return '' if const_name.nil?

        const_name.to_s.capitalize.gsub(/\_/, ' ')
      end
    end

    class WebhookType < Enumeration
      TICKET_CREATED ||= 1
      REPLY_CREATED ||= 2
      TICKET_STATUS_CHANGED ||= 8
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#agent-channel-1
    class AgentChannel < Enumeration
      NONE ||= 0
      TICKET ||= 10
      CALL_CENTER ||= 20
      CHAT ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#agent-status
    class AgentStatus < Enumeration
      ONLINE ||= 10
      IN_WORK ||= 40
      BUSY ||= 60
      OFFLINE ||= 100
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#article-resolution
    class ArticleResolution < Enumeration
      COLLECTING_VOTES ||= 110
      IN_DEVELOPMENT ||= 112
      COMING_SOON ||= 114
      RELEASED ||= 116
      INVESTIGATING ||= 120
      WORKING_ON_IT ||= 122
      RESOLVED ||= 124
      THIRD_PARTY_BUG ||= 126
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#article-status
    class ArticleStatus < Enumeration
      DRAFT ||= 0
      PUBLISHED ||= 10
      DELETED ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#article-type
    class ArticleType < Enumeration
      ARTICLE ||= 100
      FEATURE_REQUEST ||= 110
      KNOWN_ISSUE ||= 120
      VIDEO ||= 130
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#article-version-publication-status
    class ArticleVersionPublicationStatus < Enumeration
      DRAFT ||= 0
      PUBLISHED ||= 1
    end

    class AttachmentStatus < Enumeration
      FAILED ||= 1
      INVALID_EXTENSION ||= 2
      MAX_FILE_SIZE_EXCEEDED ||= 3
      OK ||= 200
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#call-participant-status
    class CallParticipantStatus < Enumeration
      CONNECTING ||= 10
      TALKING ||= 20
      ON_HOLD ||= 30
      MUTED ||= 40
      LEFT ||= 50
      DECLINED ||= 60
      NO_ANSWER ||= 70
      CANCELLED ||= 80
      INVITED ||= 90
      FAILED ||= 100
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#call-priority
    class CallPriority < Enumeration
      NORMAL ||= 0
      HIGH ||= 1
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#call-status
    class CallStatus < Enumeration
      IN_IVR ||= 10
      IN_QUEUE ||= 20
      RESERVED ||= 30
      INITIATED ||= 40
      RINGING ||= 50
      IN_PROGRESS ||= 60
      COMPLETED ||= 70
      COMPLETED_IN_IVR ||= 71
      FORWARDED ||= 72
      TRANSFERRED_TO_NUMBER ||= 73
      COMPLETED_VOICEMAIL ||= 74
      PENDING_VOICEMAIL ||= 75
      BUSY ||= 80
      FAILED ||= 90
      NO_ANSWER ||= 100
      CANCELLED ||= 110
      EXPIRED ||= 120
      TRANSFERRED_TO_QUEUE ||= 130
      ABANDONED ||= 140
      HUNG_UP_IN_QUEUE ||= 150
      HUNG_UP_IN_IVR ||= 160
      TRANSFERRED_TO_IVR ||= 170
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#call-type
    class CallType < Enumeration
      INBOUND ||= 10
      OUTBOUND ||= 20
      CALLBACK ||= 30
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

    # https://help.wixanswers.com/kb/en/article/api-enumerations#chat-message-status
    class ChatMessageStatus < Enumeration
      QUEUED ||= 10
      FAILED ||= 20
      SENT ||= 30
      DELIVERED ||= 40
      FAILED ||= 50
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#chat-message-type
    class ChatMessageType < Enumeration
      USER ||= 100
      AGENT ||= 110
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#chat-participant-status
    class ChatParticipantStatus < Enumeration
      TALKING ||= 10
      LEFT ||= 20
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#chat-status
    class ChatStatus < Enumeration
      WAITING ||= 0
      ACTIVE ||= 1
      COMPLETED ||= 2
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#content-task-priority
    class ContentTaskPriority < Enumeration
      LOW ||= 10
      NORMAL ||= 20
      HIGH ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#content-task-status
    class ContentTaskStatus < Enumeration
      OPEN ||= 10
      COMPLETED ||= 20
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#content-task-type
    class ContentTaskType < Enumeration
      WRITE ||= 10
      UPDATE ||= 20
      REVIEW ||= 30
      TRANSLATE ||= 40
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#counter-type
    class CounterType < Enumeration
      FOLLOWER ||= 10
      VIEW ||= 20
      VOTE ||= 30

      UNHELPFUL ||= 300
      RATING_1 ||= 300

      HELPFUL ||= 304
      RATING_5 ||= 304
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#custom-field-type
    class ContentTaskType < Enumeration
      TEXT ||= 1
      MULTI_LINE_TEXT ||= 2
      SINGLE_SELECT ||= 3
      MULTI_SELECT ||= 4
      NUMBER ||= 5
      CHECKBOX ||= 6
      DATE_PICKER ||= 7
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#email-status
    class EmailStatus < Enumeration
      NOT_VERIFIED ||= 0
      VERIFIED ||= 1
      INVALIDATED ||= 99
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#event-type
    class EventType < Enumeration
      ARTICLE_ADDED ||= 650
      ARTICLE_UPDATED ||= 651
      ARTICLE_CONTENT_UPDATED ||= 652
      ARTICLE_DELETED ||= 653
      ARTICLE_RESTORED ||= 654
      ARTICLE_MERGED ||= 655
      ARTICLE_UNPUBLISHED ||= 656
      ARTICLE_PUBLISHED ||= 663
      ARTICLE_LABELS_UPDATED ||= 665
      ARTICLE_PHRASES_UPDATED ||= 666
      ARTICLE_VISIBILITY_CHANGED ||= 667
      TICKET_UPDATED ||= 700
      TICKET_CONTENT_UPDATED ||= 701
      TICKET_DELETED ||= 702
      TICKET_STATUS_CHANGED ||= 703
      REPLY_DELETED ||= 705
      OUTBOUND_TICKET_ADDED ||= 707
      REPLY_CONTENT_UPDATED ||= 709
      REPLY_MOVED ||= 710
      TICKET_CREATED_FROM_REPLLY ||= 711
      TICKET_LABELS_UPDATED ||= 712
      SCHEDULED_CALL_CANCELLED ||= 713
      REPLY_MADE_INTO_TICKET ||= 714
      TICKET_LOCALE_CHANGED ||= 715
      TICKET_SET_PRIVATE ||= 716
      TICKET_ARTICLE_RELATIONS_CHANGED ||= 717
      TICKET_PRIORITY_CHANGED ||= 718
      TICKET_ASSIGNED ||= 722
      TICKET_UNASSIGNED ||= 723
      TICKET_MARKED_AS_SPAM ||= 724
      REPLY_MOVED_TO_TICKET ||= 725
      REPLY_MOVED_FROM_TICKET ||= 726
      INTERNAL_NOTE_DELETED ||= 727
      TICKET_CUSTOM_FIELDS_UPDATED ||= 728
      AGENT_REPLY_ADDED ||= 729
      TICKET_ATTACHMENTS_REMOVED ||= 730
      REPLY_ATTACHMENTS_REMOVED ||= 731
      RULE_FAILED ||= 732
      TICKET_TRANSFERRED ||= 733
      EMAIL_SENT||= 734
      REPLY_UPDATED_ON_TICKET_TRANSFERRED ||= 735
      TICKET_AUTHENTICATED ||= 736
      SLA_POLICY_ADDED_TO_TICKET ||= 737
      MACRO_APPLIED_ON_TICKET ||= 738
      AGENT_INERNAL_REPLY_ADDED ||= 739
      TICKET_AUTOMATICALLY_ASSIGNED_TO_ACCOUNT_MANAGER ||= 740
      ADD_CUSTOM_TICKET_TIMELINE_API ||= 742
      CATEGORY_ADDED ||= 800
      CATEGORY_REMOVED ||= 801
      CATEGORY_LANGUAGE_VALUES_CHANGED ||= 802
      CATEGORY_UPDATED ||= 803
      CATEGORY_MOVED ||= 804
      CHAT_TICKET_USER_UPDATED ||= 1500
      AGENT_JOINED_CHAT ||= 1501
      AGENT_LEFT_CHAT ||= 1502
      AGENT_ENDED_CHAT ||= 1503
      TICKET_HANDLING_STARTED ||= 2500
      TICKET_HANDLING_ENDED ||= 2501
      ALL_TICKET_HANDLING_ENDED ||= 2502
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#item-type874
    class ItemType < Enumeration
      CATEGORY ||= 2
      SEO_CONTENT ||= 6
      TENANT ||= 7
      TICKET ||= 8
      REPLY ||= 9
      ARTICLE ||= 10
      EMAIL_TEMPLATE ||= 14
      CONTENT_TASK ||= 40
      MAILBOX ||= 50
      USER ||= 60
      SAVED_REPLY ||= 70
      LABEL ||= 90
      URL_MAPPING ||= 110
      MULTILINGUAL_TEXT ||= 120
      SAVED_FILTER ||= 130
      PHONE_CALL ||= 150
      NOTE ||= 160
      CHAT_MESSAGE ||= 170
      CHAT ||= 175
      INTEGRATION ||= 180
      SLA_POLICY ||= 190
      GROUP ||= 200
      WIDGET ||= 210
      LINE ||= 220
      WIDGET_MULTILINGUAL_TEXTS ||= 221
      COMPANY ||= 230
      QUEUE ||= 260
      USER_ROLE ||= 280
      AGENT ||= 300
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#rating
    class Rating < Enumeration
      POSITIVE ||= 10
      NEUTRAL ||= 20
      NEGATIVE ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#reply-status
    class ReplyStatus < Enumeration
      DRAFT ||= 0
      PUBLISHED ||= 1
      DELETED ||= 2
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#reply-type
    class ReplyType < Enumeration
      USER ||= 100
      CC_USER ||= 101
      AGENT ||= 110
      INTERNAL ||= 120
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#satisfaction
    class Satisfaction < Enumeration
      NOT_AT_ALL ||= 10
      NOT_VERY ||= 10
      SOMEWHAT ||= 20
      VERY ||= 30
      EXTREMELY ||= 40
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#saved-filter-context
    class SavedFilterContext < Enumeration
      TICKET ||= 0
      CHAT ||= 10
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#saved-filter-type
    class SavedFilterType < Enumeration
      SYSTEM ||= 0
      PRIVATE ||= 10
      PUBLIC ||= 20
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#saved-reply-status
    class SavedReplyStatus < Enumeration
      DRAFT ||= 0
      PUBLISHED ||= 1
      DELETE ||= 2
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#search-type
    class SearchType < Enumeration
      EXACT ||= 1
      CONTAINS ||= 2
      NOT_CONTAINS ||= 3
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#sla-policy-status
    class SLAPolicyStatus < Enumeration
      PAUSED ||= 0
      ACTIVE ||= 1
      COMPLETED_SUCCESSFULLY ||= 2
      COMPLETED_UNSUCCESSFULLY ||= 3
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#ticket-priority
    class TicketPriority < Enumeration
      LOW ||= 10
      NORMAL ||= 20
      HIGH ||= 30
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#ticket-status
    class TicketStatus < Enumeration
      OPEN ||= 100
      PENDING ||= 110
      CLOSED ||= 120
      SOLVED = 140
      INVESTIGATING = 150
    end

    # https://help.wixanswers.com/kb/en/article/api-enumerations#user-type
    class UserType < Enumeration
      AUTHENTICATED ||= 1
      UNAUTHENTICATED ||= 2
      PENDING_AUTHENTICATION ||= 4
      PENDING_DELETION ||= 5
      DELETED ||= 99
    end
  end
end