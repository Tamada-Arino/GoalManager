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

    it 'ベースカラーが3桁のカラーコードだと登録できないこと' do
      goal = build(:goal, color: '#fff')
      expect(goal).not_to be_valid
    end

    it 'ベースカラーの最初に#がなければ登録できないこと' do
      goal = build(:goal, color: 'ff0000')
      expect(goal).not_to be_valid
    end

    it 'ベースカラーに不正な字が入って入れば登録できないこと' do
      goal = build(:goal, color: '#ff000G')
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

    context '小目標が存在する時' do
      it '小目標がすべて達成済みのとき終了日を入力することができる' do
        goal = build(:goal, end_date: '')
        create_list(:small_goal, 3, goal: goal, achievable: true)

        goal.end_date = Time.zone.today
        expect(goal).to be_valid
      end

      it '小目標のうち一つでも達成できていなければ終了日を入力できない' do
        goal = build(:goal, end_date: '')
        create(:small_goal, goal: goal, achievable: true)
        create(:small_goal, goal: goal, achievable: false)

        goal.end_date = Time.zone.today
        expect(goal).not_to be_valid
      end

      it '3つまで登録できること' do
        goal = build(:goal, end_date: '')
        create_list(:small_goal, 3, goal:)
        expect(goal).to be_valid
      end

      it '4つ以上は登録できないこと' do
        goal = build(:goal, end_date: '')
        create_list(:small_goal, 4, goal:)
        expect(goal).not_to be_valid
      end
    end
  end
end
