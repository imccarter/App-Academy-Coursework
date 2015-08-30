FactoryGirl.define do
  factory :goal do
    association :user, factory: :other_user
    title "goal title"
    content "goal content"
    # user_id 2
    private_goal false

    factory :other_private_goal do
      title 'other private goal'
      content 'other private content'
      private_goal true
    end

    factory :my_goal do
      title "my title"
      content "my content"
      user
    end

    factory :my_private_goal do
      association :user, factory: :user
      title "my private title"
      content "my private content"
      private_goal true
    end
  end

end
