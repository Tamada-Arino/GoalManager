# frozen_string_literal: true

class Goal < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :color, presence: true,
                    format: { with: /\A#(?:[0-9a-fA-F]{3}){1,2}\z/, message: :invalid_color }
  validate :start_date_check
  validate :small_goals_achievable_check
  after_validation :remove_small_goal_errors

  belongs_to :user
  has_many :reports, dependent: :destroy
  has_many :small_goals, dependent: :destroy

  def status
    if end_date.present?
      { text: '完了', class: 'tag is-success' }
    elsif interrupted
      { text: '中断中', class: 'tag is-warning' }
    elsif start_date > Time.zone.today
      { text: '開始前', class: 'tag is-light' }
    else
      { text: '進行中', class: 'tag is-primary' }
    end
  end

  private

  def start_date_check
    %i[schedules_end_date end_date].each do |target_date|
      next unless send(target_date).present? && start_date > send(target_date)

      errors.add(target_date, :start_date_invalid)
    end
  end

  def small_goals_achievable_check
    return if end_date.blank? || small_goals.all?(&:achievable)

    errors.add(:end_date, :small_goals_not_achieved_yet)
  end

  def remove_small_goal_errors
    errors.delete(:small_goals)
  end
end
