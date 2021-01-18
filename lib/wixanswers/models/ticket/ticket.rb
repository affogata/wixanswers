
# https://help.wixanswers.com/kb/en/article/api-object-structures#ticket-object

module WixAnswers
  module Models
    class Ticket < Base
      SCHEMA ||= {
          id: {type: "String", description: "Ticket ID", required: true},
          locale: {type: "String", description: "Ticket language"},
          subject: {type: "String", description: "Ticket subject", required: true},
          content: {type: "String", description: "Ticket content"},
          user: {type: "Hash", description: "User that created the ticket, or on behalf of whom the ticket was created", required: true},
          company: {type: "Hash", description: "Company associated with the ticket"},
          userInfo: {type: "Hash", description: "Structure of user system information sent by the user's browser"},
          status: {type: "Integer", description: "Ticket Status", required: true},
          priority: {type: "Integer", description: "Ticket priority", required: true},
          repliesCount: {type: "Integer", description: "Number of ticket replies (user and agent replies, not including internal notes)"},
          lastReply: {type: "Hash", description: "Last reply (user or agent, not internal note)"},
          channel: {type: "Integer", description: "The channel by which the ticket was created"},
          channelData: {type: "Hash", description: "Other data related to the channel, depending on the channel"},
          labels: {type: "Array", description: "List of labels attached to the ticket"},
          relatedArticleIds: {type: "Array", description: "List of articles that are marked as related to the ticket"},
          ticketNumber: {type: "Integer", description: "Ticket reference number", required: true},
          creationDate: {type: "Integer", description: "Time this record was created", required: true},
          lastUpdateDate: {type: "Integer", description: "Last time this record was updated"},
          assignedBy: {type: "Hash", description: "Agent who assigned the ticket"},
          createdByAgent: {type: "Hash", description: "Agent who created the ticket"},
          assignedUser: {type: "Hash", description: "Agent assigned to the ticket"},
          assignedGroup: {type: "Hash", description: "Agent group assigned to the ticket"},
          lastAgentReplyDate: {type: "Integer", description: "The time of the last agent reply"},
          lastSolvedDate: {type: "Integer", description: "The time the ticket was last solved."},
          lastOpenedDate: {type: "Integer", description: "The last time the ticket was opened"},
          lastStatusChangeDate: {type: "Integer", description: "The last time the ticket status changed"},
          handledByUserIds: {type: "Array", description: "List of user/agent IDs that have previously handled the ticket"},
          handlingUsers: {type: "Array", description: "List of user/agent IDs that are currently handling the ticket"},
          repliedByUserIds: {type: "Array", description: "List of user/agent IDs that have replied to the ticket"},
          positiveRatedUserIds: {type: "Array", description: "List of users that rated the ticket positively"},
          negativeRatedUserIds: {type: "Array", description: "List of users that rated the ticket negatively"},
          customFields: {type: "Array", description: "List of ticket custom field values"},
          hasAgentReply: {type: "Boolean", description: "Whether the ticket has a reply from an agent"},
          spam: {type: "Boolean", description: "Whether the ticket was marked as spam"},
          unauthenticated: {type: "Boolean", description: "Whether the user is unauthenticated (not registered in Wix Answers)"},
          createdOnBehalf: {type: "Boolean", description: "Whether an agent created the ticket on behalf of the user"},
          initialUserEmail: {type: "String", description: "Email address of user who created the ticket"},
          allCcUsers: {type: "Array", description: "All (current or previous) CC users associated with the ticket"},
          allCcUserIds: {type: "Array", description: "All (current or previous) CC users associated with the ticket"},
          ccUserIds: {type: "Array", description: "CC users associated with the most recent reply"},
          SLA: {type: "Hash", description: "SLA policy associated with the ticket"},
          previousLocales: {type: "String", description: "List of previous locales"},
          importId: {type: "String", description: "Import batch process"},
      }

      def initialize(attrs={})
        super(attrs)
      end

      def attachments
        @_attachments ||= (self.attrs[:attachments] || []).map {|attrs| Attachment.new(attrs)}
      end

      def user_info
        @_user_info ||= UserInfo.new(self.attrs[:userInfo] || {})
      end

      def user
        @_user ||= User.new(self.attrs[:user] || {})
      end

      def labels
        @_labels ||= (self.attrs[:labels] || []).map {|attrs| Label.new(attrs)}
      end

      def last_reply
        @_last_reply ||= Reply.new(self.attrs[:lastReply] || {})
      end

      def assigned_by
        @_assigned_by ||= User.new(self.attrs[:assignedBy] || {})
      end

      def created_by_agent
        @_created_by_agent ||= User.new(self.attrs[:createdByAgent] || {})
      end

      def assigned_user
        @_assigned_user ||= Agent.new(self.attrs[:assignedUser] || {})
      end

      def assigned_group
        @_assigned_group ||= Group.new(self.attrs[:assignedGroup] || {})
      end

      def all_cc_users
        @_all_cc_users ||= (self.attrs[:allCcUsers] || []).map {|attrs| User.new(attrs)}
      end

      def self.from_payload(payload)
        Enumerations::Channel.validate!(payload[:channel])

        case payload[:channel]
          when Enumerations::Channel::WEB
            payload[:type].nil? ? Models::Ticket.new(payload) : Models::Reply.new(payload)
          when Enumerations::Channel::BY_AGENT
            Models::ByAgent.new(payload)
          when Enumerations::Channel::EMAIL
            payload[:type].nil? ? Models::Ticket.new(payload) : Models::Reply.new(payload)
          when Enumerations::Channel::PHONE_CALLBACK
            Models::PhoneCallback.new(payload)
          when Enumerations::Channel::WIDGET
            Models::Widget.new(payload)
          else
            raise Exceptions::NotImplementedError.new('Channel', payload[:channel])
        end
      end
    end
  end
end