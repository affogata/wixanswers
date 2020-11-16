
# https://help.wixanswers.com/kb/en/article/api-object-structures#location-object
module WixAnswers
  module Models
    class Location < Base
      SCHEMA ||= {
          id: {type: 'String', description: 'The location ID', required: true},
          name: {type: 'String', description: 'The location name'},
          creationDate: {type: 'Integer', description: 'Time this record was created', required: true},
          latUpdateDate: {type: 'Integer', description: 'Last time this record was updated'},
      }
    end
  end
end