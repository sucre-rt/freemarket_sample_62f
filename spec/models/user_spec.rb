require 'rails_helper'
describe User do
  describe '#create' do
    it "is invalid without a nickname" do
      user = User.new(nickname: "", email: "kkk@gmail.com", family_name: "", first_name: "",family_name_cana: "", first_name_cana: "", birthday: "", telphone: "")
      user.valid?
      exepect(user.errors[:nickname]).to 
    end
  end
end