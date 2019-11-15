require 'rails_helper'

describe User do

  describe '#create' do

    #User登録時に全ての値が存在すれば、登録できること
    it "is valid with a nickname, email, family_name, first_name, family_name_cana, first_name_cana, birthday, telphone" do
      user = build(:user)
      expect(user).to be_valid
    end

    #profileが空でも登録できる
    it "is valid with a profile" do
      user = build(:user, profile: "")
      expect(user).to be_valid
    end

    #imageが空でも登録できる
    it "is valid with a image" do
      user = build(:user, image: "")
      expect(user).to be_valid
    end

    #pointが空でも登録できる
    it "is valid with a point" do
      user = build(:user, point: "")
      expect(user).to be_valid
    end

    #nicknameが空の時は登録できない
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

  #ここからPassword
    #passwordがからの時に登録できない
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    #password値が7文字以下では、登録できないこと
    it "is too short a password" do
      user = build(:user, password: "123456")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    #password値が128文字以上では、登録できないこと
    it "is too long a password" do
      user = build(:user, password: "023T"*33)
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
    end

    #password値が半角英字だけでは、登録できないこと
    it "is invalid EnglishCharacters only in password" do
      user = build(:user, password: "abcdefg")
      user.valid?
      expect(user.errors[:password]).to include("is invalid")
    end

    #password値が半角英字だけでは、登録できないこと
    it "is invalid Number only in password" do
      user = build(:user, password: "1234567")
      user.valid?
      expect(user.errors[:password]).to include("is invalid")
    end
  #ここまでPassword

  #ここからEmailテスト
    #emailが空の時は登録できない
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    #emailが有効な形式以外では登録できない
    it "is invalid format a email" do
      user = build(:user, email: "testtest.com")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    # 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
  #ここまでEmailテスト

    #family_nameが空の時は登録できない
    it "is invalid without a family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    #first_nameが空の時は登録できない
    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

  #ここから名前(カタカナ)
    #family_name_canaが空の時は登録できない
    it "is invalid without a family_name_cana" do
      user = build(:user, family_name_cana: "")
      user.valid?
      expect(user.errors[:family_name_cana]).to include("can't be blank")
    end

    #first_name_canaが空の時は登録できない
    it "is invalid without a first_name_cana" do
      user = build(:user, first_name_cana: "")
      user.valid?
      expect(user.errors[:first_name_cana]).to include("can't be blank")
    end

    #family_name_canaがカタカナでないと登録できない
    it "is invalid except a family_name_cana for カタカナ" do
      user = build(:user, family_name_cana: "ひらがな")
      user.valid?
      expect(user.errors[:family_name_cana]).to include("is invalid")
    end

    #first_name_canaがカタカナでないと登録できない
    it "is invalid except a first_name_cana for カタカナ" do
      user = build(:user, first_name_cana: "太郎")
      user.valid?
      expect(user.errors[:first_name_cana]).to include("is invalid")
    end
  #ここまで名前(カタカナ)

    #birthdayが空の時は登録できない
    it "is invalid without a birthday" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    #telphoneが空の時は登録できない
    it "is invalid without a telphone" do
      user = build(:user, telphone: "")
      user.valid?
      expect(user.errors[:telphone]).to include("can't be blank")
    end

  end

end
