# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SmallGoal, type: :model do
  describe '小目標登録' do
    it '小目標タイトルと達成ステータスがあれば登録できること' do
      small_goal = build(:small_goal)
      expect(small_goal).to be_valid
    end

    it '小目標タイトルがなければ登録できないこと' do
      small_goal = build(:small_goal, title: '')
      expect(small_goal).not_to be_valid
    end

    context '目標一つに対して小目標が複数ある時' do
      it '3つまで登録できること' do
        goal = build(:goal)
        create_list(:small_goal, 2, goal:)
        new_small_goal = build(:small_goal, goal:)
        expect(new_small_goal).to be_valid
      end

      it '4つ以上は登録できないこと' do
        goal = build(:goal)
        create_list(:small_goal, 3, goal:)
        new_small_goal = build(:small_goal, goal:)
        expect(goal.errors[:base]).to include('一つの目標に設定できる小目標は3つまでです')
      end
    end
  end
end
