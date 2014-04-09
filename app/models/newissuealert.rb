class Newissuealert < ActiveRecord::Base
  attr_accessible :enabled, :mail_addresses, :priority
end
