FactoryBot.define do

  factory :image_seller, class: Image do
    image   { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpg')) }
    product { FactoryBot.create :product_seller }
    images  {"1"}
  end

  factory :image_buyer, class: Image do
    image   { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpg')) }
    product { FactoryBot.create :product_buyer }
    images  {"1"}
  end

end
