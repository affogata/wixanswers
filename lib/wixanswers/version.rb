module WixAnswers
  module Version
    module_function

    def major
      0
    end

    def minor
      0
    end

    def patch
      5
    end

    def pre
      1
    end

    def to_h
      {
          major: major,
          minor: minor,
          patch: patch,
          pre: pre,
      }
    end

    def to_a
      [major, minor, patch, pre].compact
    end

    def to_s
      to_a.join('.')
    end
  end
end
