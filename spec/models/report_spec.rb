require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '日報作成' do
    it '実行日、達成度、本文があれば登録できること' do
      report = build(:report)
      expect(report).to be_valid
    end

    it '本文がなくても登録できること' do
      report = build(:report, content: '')
      expect(report).to be_valid
    end

    it '実行日がなければ登録できないこと' do
      report = build(:report, target_date: '')
      expect(report).not_to be_valid
    end

    it '達成度がなければ登録できないこと' do
      report = build(:report, progress_value: '')
      expect(report).not_to be_valid
    end

    it '達成度が負の値だと登録できないこと' do
      report = build(:report, progress_value: -1)
      expect(report).not_to be_valid
    end

    it '達成度が100より大きいと登録できないこと' do
      report = build(:report, progress_value: 101)
      expect(report).not_to be_valid
    end

    it '実行日が目標の開始日以前だと登録できないこと' do
      goal = build(:goal)
      report = build(:report, target_date: goal.start_date - 1.days)
      expect(report).not_to be_valid
    end
  end
end
