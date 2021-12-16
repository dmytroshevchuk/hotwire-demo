# frozen_string_literal: true

module Issues
  class Base < ApplicationComponent
    def initialize(issue:)
      super

      @issue = issue
    end

    attr_reader :issue
  end
end
