# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue, type: :model do
  it 'has correctly defined status enum' do
    expect(subject).to define_enum_for(:status).with_values(
      not_started: 0,
      in_progress: 1,
      testing: 2,
      accepted: 3,
      archived: 4
    )
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:airbrake_link) }
    it { is_expected.to validate_presence_of(:status) }
  end

  xdescribe '#done?' do
    let(:issue) { create(:issue) }

    %i[in_progress not_started testing].each do |status|
      context "when a status is #{status}" do
        before { issue.update(status: status) }

        it 'is not percieved as done' do
          expect(issue.reload).not_to be_done
        end
      end
    end

    %i[archived accepted].each do |status|
      context "when a status is #{status}" do
        before { issue.update(status: status) }

        it 'is percieved as done' do
          expect(issue.reload).to be_done
        end
      end
    end
  end
end
