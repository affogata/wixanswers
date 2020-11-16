
# https://help.wixanswers.com/kb/en/article/api-object-structures#agent-object
module WixAnswers
  module Models
    class Agent < User
      SCHEMA ||= User::SCHEMA.merge({
        roleId: {type: 'String', description: 'User role'},
        statusStartDate: {type: 'Integer', description: 'Time status last changed'},
        agentCreationDate: {type: 'Integer', description: 'Time this user was made an agent'},
        agentLastUpdateDate: {type: 'Integer', description: 'Last time the record of this agent was updated'},
        manager: {type: 'Hash', description: 'The agent\'s manager'},
        isManager: {type: 'Boolean', description: 'Whether this agent is a manager of one or more other agents'},
        locationId: {type: 'String', description: 'The agent\'s location'},
        teamId: {type: 'String', description: 'The agent\'s team'},
        jobTitle: {type: 'String', description: 'The agent\'s job title'},
        locales: {type: 'Array', description: 'The languages with which the agent is familiar'},
        active: {type: 'Boolean', description: 'Whether the agent is active or not'},
        supportUtilizationRate: {type: 'Integer', description: 'The agent\'s availability percentage'},
        groupIds: {type: 'Array', description: 'The groups of which this agent is a member'},
        qualifiedChannels: {type: 'Array', description: 'List of Agent Channels methods that the agent uses to communicate with users'},
        channel: {type: 'Integer', description: 'Agent Channel to which the agent is currently assigned'},
        customStatusId: {type: 'String', description: 'A custom busy status'},
        agentStatus: {type: 'Integer', description: 'Agent Status'},
        lastChatAssignedDate: {type: 'Integer', description: 'Time agent last assigned to a chat'},
        assignedQueues: {type: 'Array', description: 'List of queues to which the agent is assigned'},
        statistics: {type: 'Hash'},
        customFields: {type: 'Hash', description: 'List of agent custom field values'},
      })

      def manager
        @_manager ||= Agent.new(self.attrs[:manager] || {})
      end
    end
  end
end