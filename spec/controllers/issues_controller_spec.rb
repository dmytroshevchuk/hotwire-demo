# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssuesController, type: :controller do
  login_user

  let!(:issue) { create(:issue) }

  describe 'POST :create' do
    subject(:request) { post :create, params: params }

    context 'when data is valid' do
      let(:params) do
        {
          issue: {
            airbrake_link: Faker::Internet.url,
            trello_link: Faker::Internet.url,
            status: 'in_progress'
          }
        }
      end

      it 'creates an issue' do
        expect { request }.to change(Issue, :count).by(1)
      end
    end

    context 'when data is invalid' do
      let(:params) do
        {
          issue: { airbrake_link: '' }
        }
      end

      it { is_expected.to render_template(:new) }

      it 'does not create an issue' do
        expect { request }.to change(Issue, :count).by(0)
      end
    end
  end

  describe 'DELETE :destroy' do
    subject(:request) { delete :destroy, params: { id: issue.id } }

    it 'destroys the issue' do
      expect { request }.to change(Issue, :count).by(-1)
    end
  end

  describe 'GET :edit' do
    subject(:request) { get :edit, params: { id: issue.id } }

    it { is_expected.to be_successful }
    it { is_expected.to render_template(:edit) }

    it 'assigns @issue variable' do
      request

      expect(assigns(:issue)).to eq(issue)
    end
  end

  describe 'GET :index' do
    subject(:request) { get :index }

    before { request }

    it { is_expected.to be_successful }
    it { is_expected.to render_template(:index) }

    it 'assigns @facade variable' do
      expect(assigns(:facade)).to be_kind_of(IssuesFacade)
    end
  end

  describe 'GET :new' do
    subject { get :new }

    it { is_expected.to be_successful }
    it { is_expected.to render_template(:new) }
  end

  describe 'PUT :update' do
    subject(:request) { put :update, params: params }

    context 'when data is valid' do
      let(:params) do
        {
          id: issue.id,
          issue: { status: 'in_progress' }
        }
      end

      it 'updates the issue properly' do
        request

        expect(issue.reload).to be_in_progress
      end
    end

    context 'when data is invalid' do
      let(:params) do
        {
          id: issue.id,
          issue: { airbrake_link: '' }
        }
      end

      it { is_expected.to render_template(:edit) }

      it 'does not update an issue' do
        expect { request }.not_to change(issue, :airbrake_link)
      end
    end
  end
end
