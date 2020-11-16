
# https://help.wixanswers.com/en/article/api-object-structures#company-object
module WixAnswers
  module Models
    class Company < Base
      SCHEMA ||= {
          id: {type: "String", description: "Company ID", required: true},
      }
    end
  end
end