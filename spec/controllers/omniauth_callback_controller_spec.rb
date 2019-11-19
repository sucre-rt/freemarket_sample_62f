require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env["omniauth.auth"] = facebook_mock
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
  subject { post :facebook, params: { provider: "facebook" } }

  it "登録済みのユーザーならログインさせる" do
    request.env["omniauth.auth"] = facebook_mock
    binding.pry
    expect(response).to render_template
  end

  # it "未登録の場合はサインアップさせる" do

end