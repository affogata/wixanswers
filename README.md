# wixanswers
A Ruby Wrapper to the WIX Answers REST API

# Introduction
The WIX Answers REST API enables you to use code to interact 
with the Wix Answers back-end. You can use the API to create 
webhooks that interact with the Wix Answers front and back-ends, 
or create a new front-end app that works with the Wix Answers 
back-end. You can also use the API to get information about your 
customers and their Wix Answers history 
(Source: [Wix Answers Developers Overview](https://help.wixanswers.com/kb/en/article/wix-answers-api-overview)).

This library serves as a Ruby wrapper for the API, in order to
enable easy interfacing with WIX Answers REST API's raw payload.

# Features
* Schema-based Objects for Tickets, Users and other API objects
* Schema validation
* Enumerations and enumerations validation


# Usage Examples

**Instantiating a new Ticket directly** 
```
ticket = WixAnswers:Models::Ticket.new(<ticket_payload>)
```

**Instantiating a new Ticket via the `#from_payload` method** 
```
ticket = WixAnswers::Models::Ticket.from_payload(<ticket_payload>)
```

**Validating Enumeration**
```
WixAnswers::Enumerations::Channel.validate!(payload[:channel])
```

#Supported Ruby Versions
* \>= 2.3

#Installation

```
gem install wixanswers
```

Or via Gemfile:
```
gem 'wixanswers'
```