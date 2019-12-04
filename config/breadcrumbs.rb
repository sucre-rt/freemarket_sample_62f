crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_index_path
end

crumb :like do
  link "いいね一覧", like_mypage_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", profile_signup_path
  parent :mypage
end

crumb :pay do
  link "支払い方法", card_new_path
  parent :mypage
end

crumb :acount do
  link "本人情報の登録", edit_user_registration_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", destroy_user_session_path
  parent :mypage
end



# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
