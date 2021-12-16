# frozen_string_literal: true

module Issues
  module IssueForm
    class Component < Issues::Base
      def issue_statuses
        Issue.statuses.keys.map do |status|
          [status.humanize, status]
        end
      end
    end
  end
end
