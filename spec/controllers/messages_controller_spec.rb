require 'rails_helper'

RSpec.describe MessagesController, type: [:request, :controller] do

    it "should redirect user when not log in #create" do
      post '/messages'
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should redirect user when not log in #delete" do
      message = create(:message)
      delete '/messages/:id', id: message.id
      expect(response).to redirect_to(new_user_session_path)
    end
end
