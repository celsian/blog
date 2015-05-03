FactoryGirl.define do
  
  factory :post do
    title ""
    content "This is a default post created by FactoryGirl's factories/posts.rb."

    trait :invalid do
      content ""
    end
  end

end
