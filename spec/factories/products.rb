FactoryBot.define do

  factory :product_seller, class: Product do
    name            {"激安！アメちゃん"}
    information     {"激安の飴です"}
    price           {"999999"}
    area            {"沖縄"}
    status          {"新品、未使用"}
    sending_days    {"1~2日で発送"}
    profit          {"900000"}
    selling_status  {"出品中"}
    user
    category
    delivery        { FactoryBot.create :delivery_seller }
    brand
  end

  factory :product_buyer, class: Product do
    name            {"激安！アメちゃん"}
    information     {"激安の飴です"}
    price           {"999999"}
    area            {"沖縄"}
    status          {"新品、未使用"}
    sending_days    {"1~2日で発送"}
    profit          {"900000"}
    selling_status  {"出品中"}
    user
    category
    delivery        { FactoryBot.create :delivery_buyer }
    brand
  end
end
