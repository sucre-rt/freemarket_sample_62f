FactoryBot.define do

  factory :user do
    nickname              {"test"}
    email                 {"test@test.com"}
    initialize_with       { User.find_or_create_by(email: email)}
    password              {"test123"}
    family_name           {"目瑠花李"}
    first_name            {"太郎"}
    family_name_cana      {"メルカリ"}
    first_name_cana       {"タロウ"}
    birthday              {20191112}
    telphone              {"0120333906"}
  end

  factory :another_user, class: User do
    nickname              {"testくん"}
    email                 {"test@ggggmail.com"}
    password              {"test1111"}
    family_name           {"桜"}
    first_name            {"咲"}
    family_name_cana      {"サクラ"}
    first_name_cana       {"サク"}
    birthday              {20191112}
    telphone              {"00000000000"}
  end

end