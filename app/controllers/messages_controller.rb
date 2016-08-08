class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_receiver, only: [:create]
  
  def create
      inbox =  current_user.find_inbox(@receiver, current_user)
      @message = inbox.messages.build(message_params)
      if @message.save
        respond_to do |format|
          format.js
        end
      end
  end

  def destroy

  end

  private

  def find_receiver
    @receiver =  current_user.find_user_by_username(params[:message][:recipient])
  end

  def message_params
    params.require(:message).permit(:recipient, :content, :inbox_id)
  end
end