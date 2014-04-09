require 'redmine_newissuealerts/issue_patch'
require 'redmine_newissuealerts/project_patch'
require 'redmine_newissuealerts/projects_helper_patch'
require 'redmine_newissuealerts/hooks'

Rails.configuration.to_prepare do

  require_dependency 'project'
  unless Project < RedmineNewissuealerts::ProjectPatch
    Project.send(:include, RedmineNewissuealerts::ProjectPatch)
  end

  require_dependency 'issue'
  unless Issue.included_modules.include? RedmineNewissuealerts::IssuePatch
    Issue.send(:include, RedmineNewissuealerts::IssuePatch)
  end

  require_dependency 'projects_helper'
  unless ProjectsHelper.included_modules.include? RedmineNewissuealerts::ProjectsHelperPatch
    ProjectsHelper.send(:include, RedmineNewissuealerts::ProjectsHelperPatch)
  end


end


Redmine::Plugin.register :redmine_newissuealerts do
  name 'Redmine Newissuealerts plugin'
  author 'Emmanuel Bretelle'
  description 'Send an email to a list of addresses when a new issue is created'
  version '0.0.2'
  author_url 'http://www.debuntu.org'
  url 'http://redmine.debuntu.org/projects/redmine-newissuealerts'
  
  # This plugin adds a project module
  # It can be enabled/disabled at project level (Project settings -> Modules)
  project_module :newissuealerts do
    # These permissions have to be explicitly given
    # They will be listed on the permissions screen
    # 
    permission :edit_newissuealerts, {:projects => :settings, :newissuealerts => [:index, :edit, :update, :destroy]}, :require => :member
    permission :new_newissuealerts, {:projects => :settings, :newissuealerts => [:index, :new, :create]}, :require => :member
    permission :view_newissuealerts, {:projects => :settings, :newissuealerts => :index}, :require => :member
  end
  # A new item is added to the project menu
  #menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => 'New Issue Alerts', :after => :activity, :param => :project_id
  #menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => :newissuealert_menuitem, :param => :project_id
end

