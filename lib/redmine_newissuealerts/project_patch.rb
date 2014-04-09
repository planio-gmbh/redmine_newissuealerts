module RedmineNewissuealerts
  module ProjectPatch
    def self.included(base) # :nodoc:
      base.class_eval do
        has_many :newissuealerts
      end
    end
  end
end

