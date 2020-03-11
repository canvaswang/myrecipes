FactoryBot.define do
  factory :chef do
    chefname { 'Canvas Wang' }
    email { 'cwang@example.com' }
    password { 'mypwd' }
    password_confirmation { 'mypwd' }
  end
end
