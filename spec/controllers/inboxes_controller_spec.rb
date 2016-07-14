require 'rails_helper'

RSpec.describe InboxesController, type: [:request, :controller] do

  it "should redirect user when not log in #create" do
    post '/inboxes'
    expect(response).to redirect_to(new_user_session_path)
  end

  it "should redirect user when not log in #delete" do
    inbox = create(:inbox)
    delete '/inboxes/:id', id: inbox.id
    expect(response).to redirect_to(new_user_session_path)
  end
end