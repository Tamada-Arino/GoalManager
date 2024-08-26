# frozen_string_literal: true

# ユーザー作成
users = [
  { name: 'Alice', email: 'user1@example.com', password: 'password' },
  { name: 'Bob', email: 'user2@example.com', password: 'password' },
  { name: 'Carol', email: 'user3@example.com', password: 'password'}
]

users.each do |user|
  User.create!(user)
end

# 大目標作成
goals = [
  {
    title: 'リーダブルコード読了',
    start_date: Time.zone.today,
    color: '#ff0000',
    user_id: 1
  },
  {
    title: '1日30分運動する',
    start_date: Time.zone.today,
    color: '#00ff00',
    user_id: 2
  },
  {
    title: '基本情報技術者試験に合格する',
    start_date: Time.zone.today,
    color: '#0000ff',
    user_id: 3,
    small_goals_attributes: {
      '0' => {
        title: 'テキストをすべて読む'
      },
      '1' => {
        title: '過去問題を解く'
      }
    }
  }
]

goals.each do |goal|
  new_goal = Goal.new(
    title: goal[:title],
    start_date: goal[:start_date],
    color: goal[:color],
    user_id: goal[:user_id]
  )
  if goal.key?(:small_goals_attributes)
    goal[:small_goals_attributes].each_value do |small_goal|
      new_goal.small_goals.build(title: small_goal[:title])
    end
  end

  new_goal.save!
end

# 日報作成
reports = [
  {
    target_date: Time.zone.today,
    progress_value: 50,
    goal_id: 1,
    content: ''
  },
  {
    target_date: Time.zone.today,
    progress_value: 50,
    goal_id: 2,
    content: ''
  },
  {
    target_date: Time.zone.today,
    progress_value: 50,
    content: '今日は過去問題を解いた。正答率は70%だった。',
    goal_id: 3
  }
]

reports.each do |report|
  Report.create!(report)
end
