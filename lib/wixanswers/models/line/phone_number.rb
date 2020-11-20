
# https://help.wixanswers.com/kb/en/article/api-object-structures#phone-number-object
module WixAnswers
  module Models
    class PhoneNumber < Base
      SCHEMA ||= {
          countryCode: {type: 'String', description: 'The country code', required: true},
          number: {type: 'String', description: 'The number', required: true},
      }
    end
  end
end