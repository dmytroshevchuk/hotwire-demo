# frozen_string_literal: true

# == Schema Information
#
# Table name: issues
#
#  id            :bigint           not null, primary key
#  airbrake_link :string           not null
#  resolved_at   :datetime
#  shipped_at    :datetime
#  status        :integer          default("not_started"), not null
#  trello_link   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Issue < ApplicationRecord
  enum status: {
    not_started: 0,
    in_progress: 1,
    testing: 2,
    accepted: 3,
    archived: 4
  }

  validates :airbrake_link, :status, presence: true

  scope :by_trello_link, ->(value) { where('trello_link ILIKE ?', "%#{value}%") }
  scope :by_airbrake_link, ->(value) { where('airbrake_link ILIKE ?', "%#{value}%") }
end
