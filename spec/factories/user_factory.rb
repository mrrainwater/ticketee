FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "User-#{n}"}
    email { "#{name}@example.com".downcase }
    password "secret"
    password_confirmation {password}
    factory :admin do
      admin true
    end
  end
end