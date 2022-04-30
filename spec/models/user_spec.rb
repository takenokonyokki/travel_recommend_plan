#frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Userモデル", type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録がうまくいくとき" do
      it "内容に問題が無い場合" do
        expect(@user).to be_valid
      end
    end
    context "新規登録がうまくいかないとき" do
      it "nameが空だと登録できない" do
        @user.name = ''
        @user.valid?
        expect(@user.errors[:name]).to include("ニックネームを入力してください")
      end
      it "emailが空だと登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include("メールアドレスを入力してください")
      end
      it "emailに@がなければ登録できない" do
        @user.email = 'hogehuga.com'
        @user.valid?
        expect(@user.errors[:email]).to include("不適切なメールアドレスです")
      end
      it "重複したemailが存在する場合保存できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors[:email]).to include("既に使われているメールアドレスです")
      end
      it "passwordが空だと登録できない" do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors[:password]).to include("パスワードを入力してください")
      end
      it "passwordが半角英数字混合でなければ登録できない(英字のみ)" do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to include("不適切なパスワードです")
      end
      it "passwordが半角英数字混合でなければ登録できない(数字のみ)" do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include("不適切なパスワードです")
      end
      it 'passwordが半角でなければ登録できない' do
        @user.password = 'ＡＢｃ１２３'
        @user.password_confirmation = 'ＡＢｃ１２３'
        @user.valid?
        expect(@user.errors[:password]).to include("不適切なパスワードです")
      end
      it "passwordが半角英大文字,小文字,数字を含む6～12文字でなければ登録できない" do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors[:password]).to include("不適切なパスワードです")
      end
    end
  end
end