module OmniauthMacros
  # def login(user)
  #   login_as user, scope: :user
  # end

  def facebook_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      "provider"    =>  "facebook",
      "uid"         =>  "000000000000000",
      "info"        =>  {
        "email"         =>  "testmaru@ggggmail.com",
        "name"          =>  "test太郎",
        "image"         => "http://mock_facebook_picture.com"
      },
      "credentials" =>  {
        "token"         =>  "mock_credentails_token",
        "expires_at"    =>  1111111111,
        "expires"       =>  true
      },
      "extra"       =>  {
        "raw_info"      =>  {
          "name"            =>  "test太郎",
          "email"           =>  "testmaru@ggggmail.com",
          "id"              =>  "1234567890"
        }
      }
    })
  end
end