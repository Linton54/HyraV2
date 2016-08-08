class InboxesController < ApplicationController
  before_action :authenticate_user!
  before_action :sender_exists?, only: [:create]

  def create
    if current_user.inbox_exists?(@receiver, current_user)
      old_inbox =  current_user.find_inbox(@receiver, current_user)
      @message = old_inbox.messages.build(message_params)
      if @message.save
        respond_to do |format|
          format.js { flash.now[:notice] = "Message is sent to #{@receiver.username}" }
        end
      end
    else
      new_inbox = current_user.create_inbox(@receiver)
      @message =  new_inbox.messages.build(message_params)
      if @message.save
        respond_to do |format|
          format.js { flash.now[:notice] = "Message is sent to #{@receiver.username}" }
        end
      end
    end
  end

  def destroy

  end

  private

  def sender_exists?
    @receiver = current_user.find_user_by_username(params[:message][:recipient])

    if @receiver.nil?
      type_error(1)
    elsif  params[:message][:content].empty?
      type_error(2)
    end
  end

  def type_error(type)
    type == 1 ? flash.now[:alert] = "Username doesn't exists!" : flash.now[:alert] = "Message can't be blank!"
    respond_to { |format| format.js } if @receiver.nil?
  end

  def message_params
    params.require(:message).permit(:recipient, :inbox_id, :content)
  end
end