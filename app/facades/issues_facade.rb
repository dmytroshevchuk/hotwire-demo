# frozen_string_literal: true

class IssuesFacade
  include Rails.application.routes.url_helpers

  def initialize(scope, params)
    @scope = scope
    @params = params
    @status = params[:status]
  end

  attr_reader :status

  def collection
    @collection ||= issues.order('status, resolved_at DESC')
                          .page(params[:page])
                          .per(20)
  end

  def current_path
    status_page? ? issues_status_path(status) : root_path
  end

  def status_page?
    status.present?
  end

  def total_amount
    @total_amount ||= issues.size
  end

  private

  attr_reader :params, :scope

  def issues
    @issues ||= status_page? ? scope.send(status) : scope
  end
end
