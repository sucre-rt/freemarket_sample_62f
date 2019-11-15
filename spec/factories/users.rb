FactoryBot.define do

  factory :user do
    nickname              {"test"}
    email                 {"test@test.com"}
    password              {"test123"}
    family_name           {"目瑠花李"}
    first_name            {"太郎"}
    family_name_cana      {"メルカリ"}
    first_name_cana       {"タロウ"}
    birthday              {20191112}
    telphone              {"0120333906"}
  end

end