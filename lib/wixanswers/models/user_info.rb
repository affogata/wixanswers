
module WixAnswers
  module Models
    class UserInfo < Base
      SCHEMA ||= {
        ip: {type: "String"},
        userAgent: {type: "String"},
        operatingSystemFamily: {type: "String"},
        operatingSystemName: {type: "String"},
        operatingSystemVersion: {type: "String"},
        browserFamily: {type: "String"},
        browserName: {type: "String"},
        browserVersion: {type: "String"},
        netSpeed: {type: "String"},
        domain: {type: "String"},
        ispName: {type: "String"},
        organization: {type: "String"},
        city: {type: "String"},
        regionName: {type: "String"},
        postalCode: {type: "String"},
        metroCode: {type: "String"},
        areaCode: {type: "String"},
        countryCode: {type: "String"},
        countryName: {type: "String"},
        continentCode: {type: "String"},
        latitude: {type: "Integer"},
        longitude: {type: "Integer"},
        timezone: {type: "String"},
        asNumber: {type: "String"},
        ipUserType: {type: "String"},
        processed: {type: "Boolean"},
      }

      def initialize(attrs={})
        super(attrs)
      end

      def validate!
        # does not require validation
        self
      end
    end
  end
end
