# frozen_string_literal: true

class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_issue, only: %i[destroy edit update]

  has_scope :trello_link, allow_blank: true do |_controller, scope, value|
    scope.by_trello_link(value)
  end

  has_scope :airbrake_link, allow_blank: true do |_controller, scope, value|
    scope.by_airbrake_link(value)
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    @issue.destroy

    redirect_to :root
  end

  def edit; end

  def index
    return redirect_to(:root) if unaccaptable_status?

    @facade = IssuesFacade.new(apply_scopes(Issue.all), params)
  end

  def new
    @issue = Issue.new
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to :root }
        format.json { render json: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors }
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(
      :airbrake_link,
      :resolved_at,
      :shipped_at,
      :status,
      :trello_link
    )
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def unaccaptable_status?
    params.key?(:status) && Issue.statuses.keys.exclude?(params[:status])
  end
end
