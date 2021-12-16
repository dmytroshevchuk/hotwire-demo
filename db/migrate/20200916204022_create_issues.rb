# frozen_string_literal: true

class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :airbrake_link, null: false
      t.string :trello_link
      t.integer :status, null: false, default: 0
      t.datetime :shipped_at
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
