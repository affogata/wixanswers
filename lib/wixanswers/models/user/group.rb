
# https://help.wixanswers.com/kb/en/article/api-object-structures#group-object
module WixAnswers
  module Models
    class Group < Base
      SCHEMA ||= {
          id: {type: 'String', description: 'The group ID', required: true},
          name: {type: 'String', description: 'The group name, between 1 and 100 characters'},
          settings: {type: 'Hash'},
          creationDate: {type: 'Integer', description: 'Time this record was created', required: true},
          latUpdateDate: {type: 'Integer', description: 'Last time this record was updated'},
          membersCount: {type: 'Integer', description: 'Number of agents in the group'},
          members: {type: 'Array', description: 'List of agents in the group'},
      }

      def members
        @members ||= (self.attrs[:members] || []).map {|member| Agent.new(member)}
      end
    end
  end
end