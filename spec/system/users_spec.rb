# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ユーザーログイン前のテスト", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "トップ画面のテスト" do
    before do
      visit root_path
    end
    context "メインの表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/'
      end
      it "「ログイン」ボタンがあり、リンクの内容が正しい" do
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
      it "「ゲストログイン」ボタンがあり、リンクの内容が正しい" do
        expect(page).to have_link "ゲストログイン", href: users_guest_sign_in_path
      end
    end
    context "ヘッダーの表示内容" do
      it "旅行アイコン画像があり、リンクの内容が正しい" do
        expect(page).to have_link "旅行アイコン", href: root_path
      end
      it "「新規登録」があり、リンクの内容が正しい" do
        expect(page).to have_link "新規登録", href: new_user_registration_path
      end
      it "「ログイン」があり、リンクの内容が正しい" do
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
    end
  end

  describe "ユーザー新規登録のテスト" do
    before do
      visit new_user_registration_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/users/sign_up'
      end
      it "「新規アカウント作成」と表示される" do
        expect(page).to have_content "新規アカウント作成"
      end
      it "nameフォームが表示される" do
        expect(page).to have_field "user[name]"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "user[email]"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "password_confirmationフォームが表示される" do
        expect(page).to have_field "user[password_confirmation]"
      end
      it "画像を選択フォームが表示される" do
        expect(page).to have_content "画像を選択"
      end
      it "新規登録ボタンが表示される" do
        expect(page).to have_button "新規登録"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_link "ログイン"
      end
    end
    context "新規登録成功のテスト" do
      before do
        fill_in "user[name]", with: @user.name
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        fill_in "user[password_confirmation]", with: @user.password_confirmation
        page.attach_file("user[image]", Rails.root + 'spec/factories/test.jpg')
      end
      it "正しく新規登録される" do
        expect { click_button "新規登録" }.to change(User.all, :count).by(1)
      end
      it "新規登録後のリダイレクト先が、投稿一覧画面になっている" do
        click_button "新規登録"
        expect(current_path).to eq plans_path
      end
    end
  end

end