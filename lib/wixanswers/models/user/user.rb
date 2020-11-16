
# https://help.wixanswers.com/kb/en/article/api-object-structures#user-object
module WixAnswers
  module Models
    class User < Base
      SCHEMA ||= {
          id: {type: "String", description: "User ID", required: true},
          firstName: {type: "String", description: "User first name"},
          lastName: {type: "String", description: "User last name"},
          userType: {type: 'Integer', description: "User Type", required: true},
          email: {type: "String", description: "User email address, up to 200 characters. Must be unique to this user object."},
          emailStatus: {type: "String", description: "Email Status"},
          lastUpdateDate: {type: "Integer", description: "Time this record was last updated"},
          profileImage: {type: "String", description: "URL of user’s profile image"},
          signature: {type: "String", description: "URL of signature"},
          phoneNumbers: {type: "Array", description: "List of phone numbers"},
          company: {type: "Hash", description: "Associated company"},
          isPartner: {type: "Boolean", description: "Whether the user is a partner"},
          companyIds: {type: "Array", description: "List of associated companies"},
          externalId: {type: "String", description: "Relevant only for tenants supporting SSO - the external ID in the tenant’s SSO auth system"},
          creationDate: {type: "Integer", description: "Time this record was created"},
          customFields: {type: "Hash", description: "List of user custom field values"},
          banned: {type: "Boolean", description: "Whether the user is banned"},
          importId: {type: "Boolean", description: "Import batch process"},
      }

      def validate!
        super

        Enumerations::UserType.validate!(self.userType)
      end
    end
  end
end