# frozen_string_literal: true

Issue.destroy_all

%i[not_started not_started not_started].each do |status|
  Issue.create(
    airbrake_link: Faker::Internet.url,
    trello_link: Faker::Internet.url,
    status: status
  )
end

Issue.create(
  airbrake_link: Faker::Internet.url,
  trello_link: Faker::Internet.url,
  status: :accepted,
  shipped_at: Time.now.utc
)

Issue.create(
  airbrake_link: Faker::Internet.url,
  trello_link: Faker::Internet.url,
  status: :archived,
  shipped_at: 1.day.ago,
  resolved_at: Time.now.utc
)
