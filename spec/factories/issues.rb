# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    airbrake_link { Faker::Internet.url }
    trello_link { Faker::Internet.url }
    status { :not_started }

    trait :in_progress do
      status { :in_progress }
    end

    trait :accepted do
      status { :accepted }
      shipped_at { Time.now.utc }
    end
  end
end
