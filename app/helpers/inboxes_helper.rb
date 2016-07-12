module InboxesHelper

  def inbox
    @inbox ||= Inbox.new
  end
end
