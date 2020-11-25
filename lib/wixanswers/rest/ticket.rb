

module WixAnswers
  module REST
    module Ticket
      # Create a ticket for the authenticated user associated with the JWT token
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#add-a-ticket-as-an-authenticated-user
      # @authorization Requires user authorization token for specific user
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param options [Hash] A customizable set of options
      # @option subject [String] A short description of the problem or question
      # @option content [String] A complete description of the problem or question
      # @option locale [String] The locale for the ticket
      def add(options = {})
        WixAnswers::Models::Ticket.new(perform_request("/tickets", :post, options))
      end

      # Create a ticket on behalf of an authenticated or unauthenticated user.
      # Use this in response to a user request where the agent creates the ticket
      # based on that request on behalf of the user.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#add-a-ticket-as-an-agent-on-behalf-of-a-user
      # @authorization Requires agent authorization token and permission CREATE_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param options [Hash] A customizable set of options
      # @option recipientEmail [String] Email of the user this ticket is created for.
      #                                 Either this parameter or recipientId is required.
      # @option recipientId [String] ID of the user this ticket is created for
      # @option subject [String] A short description of the problem or question
      # @option content [String] A complete description of the problem or question
      # @option locale [String] The locale for the ticket
      def add_on_behalf(options = {})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/onBehalf", :post, options))
      end

      # Create a new ticket for an unauthenticated user who has provided an email address.
      # Use this API only when a user GUID is not available, for example when an unregistered
      # user creates a ticket on your site or widget.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#add-a-guest-unauthenticated-user-ticket
      # @authorization Requires agent authorization token and permission CREATE_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param options [Hash] A customizable set of options
      # @option userEmail [String] Email of the user this ticket is associated with
      # @option subject [String] A short description of the problem or question
      # @option content [String] A complete description of the problem or question
      # @option locale [String] The locale for the ticket
      def add_as_guest(options = {})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/guest", :post, options))
      end

      # Create a new ticket from an existing user reply. The new ticket takes many of its details
      # (user, priority, status, and so forth) from the existing ticket, and the new contents from the reply.
      # After creating the ticket, Wix Answer invokes the Ticket Created webhook.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#convert-a-user-reply-into-a-new-ticket
      # @authorization Requires agent authorization token and permission CREATE_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] ticket GUID
      # @param reply_id [String] reply GUID
      # @param options [Hash] A customizable set of options
      # @option subject [String] A short description of the problem or question
      def add_as_agent(ticket_id, reply_id, options = {})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/replies/#{reply_id}/createTicket", :post, options))
      end

      # Create a new callback request ticket to the passed phone number, for the user associated with the JWT token.
      # Requires a line that supports outbound calls.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#add-a-phone-callback-request-ticket
      # @authorization Requires user authorization token for specific user
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param options [Hash] A customizable set of options
      # @option phoneNumber [Hash, WixAnswers::Models::PhoneNumber] Phone number to call back
      # @option lineId [Integer] The account's phone line ID from which the callback will take place.
      #                          See Call Center Lines APIs.
      def add_callback_request(options = {})
        options[:phoneNumber] = options[:phoneNumber].is_a?(WixAnswers::Models::PhoneNumber) ? options[:phoneNumber].attrs : options[:phoneNumber]
        WixAnswers::Models::Ticket.new(perform_request("/tickets/callbackRequests", :post, options))
      end

      # Get a ticket by its ID. This requires agent privileges; to get one of your own tickets
      # (with user privileges), see Get One of Your Tickets by ID.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#get-a-ticket-by-id
      # @authorization Requires agent authorization token and permission FETCH_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def ticket(ticket_id)
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/admin"))
      end
      alias find_by_id ticket

      # Get a ticket by its ticket reference number (issue ID). This requires agent privileges;
      # to get one of your own tickets (with user privileges), see Get One of Your Tickets by ID.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#get-a-ticket-by-ticket-reference-number
      # @authorization Requires agent authorization token and permission FETCH_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_number [Integer] Ticket Number
      def find_by_number(ticket_number)
        WixAnswers::Models::Ticket.new(perform_request("/tickets/byNumber/#{ticket_number}/admin"))
      end

      # Get one of your tickets by its ID. The main use-case for this API is from the Help Center.
      # If you have agent privileges, you can get any ticket by its reference number or id;
      # see Get a Ticket by Ticket Reference Number.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#get-a-ticket-by-ticket-reference-number
      # @authorization Requires agent authorization token and permission FETCH_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def my_ticket(ticket_id)
        WixAnswers::Models::Ticket.new(perform_request("/tickets/byNumber/#{ticket_id}/my"))
      end

      # Get list of tickets that match the search/filtering criteria.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#search-tickets-agent
      # @authorization Requires agent authorization token and permission FETCH_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return [Array<WixAnswers::Models::Ticket>]
      # @param options [Hash] A customizable set of options
      def search(options = {})
        perform_request("/tickets/search/admin", :post, options).map {|ticket| WixAnswers::Models::Ticket.new(ticket) }
      end

      # Get list of your tickets that match the search/filtering criteria.
      # The main use-case for this API is from the Help Center.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#search-your-tickets1097
      # @authorization Requires user authorization token for specific user
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return [Array<WixAnswers::Models::Ticket>]
      # @param options [Hash] A customizable set of options
      def search_mine(options = {})
        perform_request("/tickets/my", :post, options).map {|ticket| WixAnswers::Models::Ticket.new(ticket) }
      end

      # Get the number of tickets matching one or more saved filters.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#get-the-number-of-tickets-matching-one-or-more-saved-filters
      # @authorization Requires agent authorization token and permission FETCH_TICKET_VIEWS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return [Hash]
      # @param options [Hash] A customizable set of options
      # @option locale [String] Get the number of tickets matching one or more saved filters.
      def count(options = {})
        perform_request("/tickets/filtersCounts", :post, options)
      end

      # Assign a ticket to an agent or an agent group.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#assign-a-ticket
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def assign(ticket_id)
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/assign", :post))
      end

      # Assign one or more tickets to an agent or an agent group.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#assign-one-or-more-tickets
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <Array[WixAnswers::Models::Ticket]>
      # @param options [Hash] A customizable set of options
      # @option ids [String] List of tickets to assign.
      # @option assignedGroupId [String] The agent group to which to assign the ticket.
      #                                  This parameter or assignedUserId is required (but not both.
      # @option assignedUserId [String] The agent to whom to assign the ticket.
      #                                 This parameter or assignedGroupId is required (but not both).
      def assign_many(options={})
        perform_request("/tickets/assign", :post, options).map {|ticket| WixAnswers::Models::Ticket.new(ticket)}
      end

      # Remove the agent or group assignment from a ticket.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#unassign-a-ticket
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def unassign(ticket_id)
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/unassign", :post))
      end

      # Remove the agent or group assignment from one or more tickets.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#unassign-one-or-more-tickets
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <Array[WixAnswers::Models::Ticket]>
      # @param options [Hash] A customizable set of options
      # @option ids [String] List of tickets to unassign.
      # @option assignedGroupId [String] The agent group to which to unassign the ticket.
      #                                  This parameter or assignedUserId is required (but not both.
      # @option assignedUserId [String] The agent to whom to unassign the ticket.
      #                                 This parameter or assignedGroupId is required (but not both).
      def unassign_many(options={})
        perform_request("/tickets/unassign", :post, options).map {|ticket| WixAnswers::Models::Ticket.new(ticket)}
      end

      # Mark a ticket as spam
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#mark-a-ticket-as-spam
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def mark_spam(ticket_id)
        perform_request("/tickets/#{ticket_id}/markSpam", :post)
      end

      # Mark a ticket as not spam
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#mark-a-ticket-as-not-spam
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def mark_not_spam(ticket_id)
        perform_request("/tickets/#{ticket_id}/markHam", :post)
      end

      # Mark one or more tickets as spam
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#mark-one-or-more-tickets-as-spam
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <Array[WixAnswers::Models::Ticket]>
      # @param options [Hash] A customizable set of options
      # @option ids [String] List of tickets to mark as spam.
      def mark_spam_many(options={})
        perform_request("/tickets/markSpam", :post, options)
      end

      # Mark one or more tickets as not spam
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#mark-one-or-more-tickets-as-not-spam
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <Array[WixAnswers::Models::Ticket]>
      # @param options [Hash] A customizable set of options
      # @option ids [String] List of tickets to mark as spam.
      def mark_not_spam_many(options={})
        perform_request("/tickets/markHam", :post, options)
      end

      # Authenticate a ticket.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#authenticate-a-ticket
      # @authorization Requires agent authorization token and permission MANAGE_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      def authenticate(ticket_id)
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/authenticate", :post))
      end

      # Transfer a ticket; this changes the user associated with a ticket. Use when an existing ticket
      # is found to be relevant for the user, such as one opened initially for an unauthenticated user.
      # For example, when a) an unauthenticated user is created from an email and then b) an agent moves
      # the ticket to an existing authenticated user.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#change-a-tickets-user-transfer-a-ticket
      # @authorization Requires agent authorization token and permission MANAGE_TICKETS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      # @param options [Hash] A customizable set of options
      # @option targetUserId [String] The new user
      def transfer(ticket_id, options={})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/transfer", :post, options))
      end

      # Update a ticket's status
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#update-a-tickets-status
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      # @param options [Hash] A customizable set of options
      # @option status [Integer] The new Ticket Status
      def update_status(ticket_id, options={})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/status", :put, options))
      end

      # Update one or more tickets' statuses
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#update-status-of-one-or-more-tickets
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <Array[WixAnswers::Models::Ticket]>
      # @param options [Hash] A customizable set of options
      # @option ids [Array<String>] List of tickets for which to change the status
      # @option status [Integer] The new Ticket Status
      def update_status_many(options={})
        perform_request("/tickets/setStatus", :post, options).map {|ticket| WixAnswers::Models::Ticket.new(ticket)}
      end

      # Update a ticket's priority
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#update-a-tickets-priority
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <WixAnswers::Models::Ticket>
      # @param ticket_id [String] Ticket GUID
      # @param options [Hash] A customizable set of options
      # @option priority [Integer] New Ticket Priority
      def update_priority(ticket_id, options={})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/#{ticket_id}/priority", :put, options))
      end

      # Update one or more tickets' priorities
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#update-priority-of-one-or-more-tickets
      # @authorization Requires agent authorization token and permission BASIC_TICKET_ACTIONS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return <Array[WixAnswers::Models::Ticket]>
      # @param options [Hash] A customizable set of options
      # @option ids [Array<String>] List of tickets for which to change the status
      # @option priority [Integer] New Ticket Priority
      def update_priority_many(options={})
        perform_request("/tickets/setPriority", :post, options).map {|ticket| WixAnswers::Models::Ticket.new(ticket)}
      end
    end
  end
end