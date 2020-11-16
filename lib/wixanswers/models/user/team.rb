
# https://help.wixanswers.com/kb/en/article/api-object-structures#team-object
module WixAnswers
  module Models
    class Team < Base
      SCHEMA ||= {
          id: {type: 'String', description: 'The team ID', required: true},
          name: {type: 'String', description: 'The team name'},
          creationDate: {type: 'Integer', description: 'Time this record was created', required: true},
          latUpdateDate: {type: 'Integer', description: 'Last time this record was updated'},
      }
    end
  end
end