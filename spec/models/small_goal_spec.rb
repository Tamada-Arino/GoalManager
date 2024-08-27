require 'rails_helper'

RSpec.describe SmallGoal, type: :model do
  describe '小目標登録' do
    it '小目標タイトルと達成状況があれば登録できること' do
      small_goal = build(:small_goal)
      expect(small_goal).to be_valid
    end

    it '小目標タイトルがなければ登録できないこと' do
      small_goal = build(:small_goal, title: '')
      expect(small_goal).not_to be_valid
    end
  end
end
