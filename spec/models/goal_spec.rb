# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe '目標作成' do
    it 'タイトル、開始日、終了予定日、達成日、中断中、ベースカラー、ユーザーIDがあれば登録できること' do
      goal = build(:goal)
      expect(goal).to be_valid
    end

    it '終了予定日がなくても登録できること' do
      goal = build(:goal, schedules_end_date: '')
      expect(goal).to be_valid
    end

    it '達成日がなくても登録できること' do
      goal = build(:goal, end_date: '')
      expect(goal).to be_valid
    end

    it 'タイトルがなければ登録できないこと' do
      goal = build(:goal, title: '')
      expect(goal).not_to be_valid
    end

    it '開始日がなければ登録できないこと' do
      goal = build(:goal, start_date: '')
      expect(goal).not_to be_valid
    end

    it 'ベースカラーがなければ登録できないこと' do
      goal = build(:goal, color: '')
      expect(goal).not_to be_valid
    end

    it 'ベースカラーが色名だと登録できないこと' do
      goal = build(:goal, color: 'red')
      expect(goal).not_to be_valid
    end

    it '終了予定日が開始日より前だと登録できないこと' do
      goal = build(:goal, schedules_end_date: Time.zone.today - 1)
      expect(goal).not_to be_valid
    end

    it '達成日が開始日より前だと登録できないこと' do
      goal = build(:goal, end_date: Time.zone.today - 1)
      expect(goal).not_to be_valid
    end
  end
end
