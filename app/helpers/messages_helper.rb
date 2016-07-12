module MessagesHelper

  def message
    @message ||= Message.new
  end
end
