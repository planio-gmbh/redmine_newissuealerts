require "mailer"

class NewissuealertsMailer < Mailer

  def newissuealert( email, issue, newissuealert)
    project = issue.project
    redmine_headers 'Project' => project.identifier,
                    'Issue-Id' => issue.id,
                    'Issue-Author' => issue.author.login
    redmine_headers 'Issue-Assignee' => issue.assigned_to.login if issue.assigned_to
    headers 'X-Priority' => 1, 'Importance' => 'High', 'X-MSMail-Priority' => 'High' if newissuealert.priority
    message_id issue
    @issue = issue
    @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue)
    mail to: email,
         subject: "[#{project.name} - #{issue.tracker.name} ##{issue.id}] (#{issue.status.name}) #{issue.subject}",
         from: issue_mail_from(issue)
  end

end
