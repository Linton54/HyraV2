require 'rails_helper'

RSpec.describe RelationshipsController, type: [:request, :controller] do

  it "should redirect create when not log in" do
    post '/relationships'
    expect(response).to redirect_to(new_user_session_path)
  end

  it "should redirect destroy when not log in" do
    user = build(:user)
    delete '/relationships/:id', id: user
    expect(response).to redirect_to(new_user_session_path)
  end
end
