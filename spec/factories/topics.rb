FactoryGirl.define do
    factory :topic do
      title "Topic"
      description "Topic Description"
      user_id { create(:user,:admin).id}

    end
  end
