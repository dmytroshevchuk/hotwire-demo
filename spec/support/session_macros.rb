# frozen_string_literal: true

module SessionMacros
  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user)
    end
  end
end
