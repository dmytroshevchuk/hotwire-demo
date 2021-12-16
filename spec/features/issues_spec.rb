# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Issues', type: :feature, js_errors: true do
  let(:user) { create(:user) }
  let!(:issue) { create(:issue, :in_progress) }

  before do
    create(:issue, :accepted)
    login_as(user, scope: :user)
  end

  it 'allows to change the status of issue' do
    visit(root_path)

    expect(page).to have_selector('.issues-table')

    within('.issues-table') do
      expect(page).to have_selector('tr', count: 3)

      click_on 'In progress'

      expect(page).to have_button('Testing')
      expect(issue.reload).to be_testing
    end
  end
end
