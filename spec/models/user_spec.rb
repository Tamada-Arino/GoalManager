require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    it 'ユーザー名、メールアドレス、パスワード、パスワード（確認用）が存在すれば登録できること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'ユーザー名が空白の時登録できないこと' do
      user = build(:user, name: '')
      expect(user).not_to be_valid
    end

    it 'メールアドレスが空白の時登録できないこと' do
      user = build(:user, email: '')
      expect(user).not_to be_valid
    end

    it 'メールアドレスが通常の文字列の時登録できないこと' do
      user = build(:user, email: 'text')
      expect(user).not_to be_valid
    end

    it 'パスワードが空白の時登録できないこと' do
      user = build(:user, password: '')
      expect(user).not_to be_valid
    end

    it 'パスワード（確認用）が空白の時登録できないこと' do
      user = build(:user, password_confirmation: '')
      expect(user).not_to be_valid
    end

    it 'パスワードとパスワード（確認用）が違う文字列の場合登録できないこと' do
      user = build(:user, password_confirmation: 'another_password')
      expect(user).not_to be_valid
    end

    it 'パスワード6文字未満の時登録できないこと' do
      user = build(:user, password: 'a' * 5, password_confirmation: 'a' * 5)
      expect(user).not_to be_valid
  end
end
