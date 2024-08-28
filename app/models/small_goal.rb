# frozen_string_literal: true

class SmallGoal < ApplicationRecord
  validates :title, presence: true

  belongs_to :goal
  has_many :reports, dependent: :nullify
end
