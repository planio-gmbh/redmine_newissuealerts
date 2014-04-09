module RedmineNewissuealerts
  module IssuePatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        after_create :newissue_created
      end
    end
  end

  module InstanceMethods
    def newissue_created
      return if is_private?
      Newissuealert.where(project_id: self.project_id, enabled: true).all.each do |n|
        n.mail_addresses.split(",").each do |e|
          NewissuealertsMailer.newissuealert(e, self, n).deliver
        end
      end
    end

  end
end
