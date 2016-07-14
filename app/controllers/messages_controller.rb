class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_receiver, only: [:create]
  
  def create
    if current_user.rs_inbox_exists?(@receiver, current_user)
      old_inbox =  current_user.find_inbox(@receiver, current_user)
      @message = old_inbox.messages.build(message_params)
      if @message.save
        respond_to do |format|
          format.js
        end
      end
    else
      new_inbox = current_user.create_inbox(@receiver)
      @message = new_inbox.messages.build(message_params)
      if @message.save
        respond_to do |format|
          format.js
        end
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