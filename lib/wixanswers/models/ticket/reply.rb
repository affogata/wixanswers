
# https://help.wixanswers.com/kb/en/article/api-object-structures#reply-object
module WixAnswers
  module Models
    class Reply < Base
      SCHEMA ||= {
          id: {type: "String", description: "Reply ID", required: true},
          ticketId: {type: "String", description: "The ticket to which this reply is attached", required: true},
          content: {type: "String", description: "Reply content HTML"},
          type: {type: "Integer", description: "Reply Type", required: true},
          attachments: {type: "Array", description: "List of reply attachments"},
          ccRecipients: {type: "Array", description: "Current CC email addresses associated with the reply"},
          slaState: {type: "Hash", description: "SLA policy associated with the reply"},
          newTicketStatus: {type: "Integer", description: "New Ticket Status. Relevant when the ticket status is changed when the reply is attached."},
          user: {type: "Hash", description: "The user or agent that wrote the reply", required: true},
          userInfo: {type: "Hash", description: "Structure of user system information sent by the user's browser"},
          channel: {type: "Integer", description: "How the reply was created", required: true},
          webChannelData: {type: "Hash", description: "Additional data is channel is web"},
          chatChannelData: {type: "Hash", description: "Additional data if channel is chat"},
          widgetChannelData: {type: "Hash", description: "Additional data if channel is widget"},
          emailChannelData: {type: "Hash", description: "Additional data if channel is email"},
          facebookChannelData: {type: "Hash", description: "Additional data if channel is facebook"},
          timelineItemType: {type: "Integer", description: "For a reply, this is always 9"},
          deleted: {type: "Boolean", description: "Whether this reply was deleted"},
          creationDate: {type: "Integer", description: "Time this record was created", required: true},
          lastUpdateDate: {type: "Integer", description: "Last time this record was updated"},
          importId: {type: "String", description: "Import batch process"},
          parentTicket: {type: "Hash", required: true},
      }

      def initialize(attrs={})
        super(attrs)
      end

      def validate!
        Enumerations::ReplyType.validate!(self.attrs[:type])
        super
      end

      def user
        @_user ||= User.new(self.attrs[:user] || {})
      end

      def ticket
        return @_ticket if defined?(@_ticket)

        attrs = self.attrs[:parentTicket]
        return if attrs.nil?

        @_ticket = Ticket.from_payload(attrs)
      end

      def user_info
        self.ticket.user_info unless self.ticket.nil?
      end
    end
  end
end