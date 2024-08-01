class SmallGoal < ApplicationRecord
  belongs_to :goal
  has_many :reports
end
