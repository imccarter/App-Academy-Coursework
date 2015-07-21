FactoryGirl.define do
  factory :user do
    username "my_name"
    password "password"

    factory :other_user do
      username "other_user"
    end
  end
end
