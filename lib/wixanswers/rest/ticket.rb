

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
        WixAnswers::Models::Ticket.new(perform_request("/tickets/search/admin", :post, options))
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
        WixAnswers::Models::Ticket.new(perform_request("/tickets/my", :post, options))
      end

      # Get the number of tickets matching one or more saved filters.
      #
      # @see https://help.wixanswers.com/kb/en/article/ticket-apis#get-the-number-of-tickets-matching-one-or-more-saved-filters
      # @authorization Requires agent authorization token and permission FETCH_TICKET_VIEWS
      # @raise [WixAnswers::Exceptions::Unauthorized] Error raised when supplied agent credentials are not valid.
      # @return [Array<WixAnswers::Models::Ticket>]
      # @param options [Hash] A customizable set of options
      # @option locale [String] Get the number of tickets matching one or more saved filters.
      def count(options = {})
        WixAnswers::Models::Ticket.new(perform_request("/tickets/filtersCounts", :post, options))
      end
    end
  end
end