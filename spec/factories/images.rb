FactoryBot.define do

  factory :image do
    image   {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpg'))}
    product
    images  {"1"}
  end

end
