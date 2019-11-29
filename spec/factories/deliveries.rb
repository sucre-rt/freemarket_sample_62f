FactoryBot.define do
  factory :delivery_seller, class: Delivery do
    responsibility  {"送料込み（出品者負担）"}
    way             {"らくらくメルカリ便"}
  end

  factory :delivery_buyer, class: Delivery do
    responsibility  {"着払い（購入者負担）"}
    way             {"クロネコヤマト"}
  end
end
