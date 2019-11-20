require 'rails_helper'


RSpec.describe SnsCredential, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end

  # factorybotの確認
  it "factory_botがuserを作成できている" do
    user = @user
    expect(user).to be_valid
  end
  it "factory_botがanother_userを作成できている" do
    another_user = @another_user
    expect(another_user).to be_valid
  end

  describe '#create' do

    # SnsCredentialsモデルのバリデーションテスト
    it "uid・provider・user_idが全て入っていれば登録できる" do
      user = @user
      sns = user.sns_credentials.build(
        uid:        111111111111111,
        provider:   "facebook",
        user_id:    1
      )
      expect(sns).to be_valid
    end

    it "uidがなければ登録できない" do
      user = @user
      sns = user.sns_credentials.build(
        uid:        nil,
        provider:   "facebook",
        user_id:    1
      )
      sns.valid?
      expect(sns.errors[:uid]).to include("can't be blank")
    end

    it "providerがなければ登録できない" do
      user = @user
      sns = user.sns_credentials.build(
        uid:        "00000000000000",
        provider:   nil,
        user_id:    1
      )
      sns.valid?
      expect(sns.errors[:provider]).to include("can't be blank")
    end

    it "user_idがなければ登録できない" do
      sns = SnsCredential.new(
        uid:        "00000000000000",
        provider:   "facebook",
        user_id:    nil
      )
      sns.valid?
      expect(sns.errors[:user]).to include("must exist")
    end

    it "同じuidは登録できない" do
      user = @user
      user.sns_credentials.create(
        uid:        "000000000000000",
        provider:   "facebook",
        user_id:    1
      )
      another_user = @another_user
      sns = another_user.sns_credentials.build(
        uid:      "000000000000000",
        provider: "facebook",
        user_id:  2
      )
      sns.valid?
      expect(sns.errors[:uid]).to include("has already been taken")
    end

    it "uidが違う場合は、同じproviderでも登録できる" do
      user = @user
      user.sns_credentials.create(
        uid:      "000000000000000",
        provider: "facebook",
        user_id:  1
      )
      another_user = @another_user
      sns = another_user.sns_credentials.build(
        uid:      "111111111111111",
        provider: "facebook",
        user_id:  2
      )
      expect(sns).to be_valid
    end
    
  end

end
