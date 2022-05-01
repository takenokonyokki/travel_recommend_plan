# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ユーザーログイン前のテスト", type: :system do
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
      @user = FactoryBot.build(:user)
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
    context "新規登録失敗のテスト" do
      before do
        fill_in "user[name]", with: ''
        fill_in "user[email]", with: ''
        fill_in "user[password]", with: ''
        fill_in "user[password_confirmation]", with: ''
      end
      it "ユーザー登録されないのでカウントは上がらない" do
        expect { click_button "新規登録" }.to change(User.all, :count).by(0)
      end
      it "リダイレクト先が、新規登録画面になっている" do
        click_button "新規登録"
        expect(current_path).to eq ('/users')
      end
    end
  end

  describe "ログインのテスト" do
    before do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/users/sign_in'
      end
      it "「ログイン」と表示される" do
        expect(page).to have_content "ログイン"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "user[email]"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
      it "新規登録ボタンが表示される" do
        expect(page).to have_link "新規登録"
      end
    end
    context "ログイン成功のテスト" do
      before do
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        click_button "ログイン"
      end
      it "ログイン後のリダイレクト先が、投稿一覧画面になっている" do
        expect(current_path).to eq plans_path
      end
    end
    context "ログイン失敗のテスト" do
      before do
        fill_in "user[email]", with: ''
        fill_in "user[password]", with: ''
        click_button "ログイン"
      end
      it "リダイレクト先が、ログイン画面になっている" do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe "ログインしているときのヘッダーのテスト" do
    before do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: @user.password
      click_button "ログイン"
    end
    context "ヘッダーの表示の確認" do
      it "旅行アイコン画像があり、リンクの内容が正しい" do
        expect(page).to have_link "旅行アイコン", href: root_path
      end
      it "「投稿」があり、リンクの内容が正しい" do
        expect(page).to have_link "投稿", href: new_plan_path
      end
      it "「マイページ」があり、リンクの内容が正しい" do
        expect(page).to have_link "マイページ", href: mypage_plans_path
      end
      it "「いいね」があり、リンクの内容が正しい" do
        expect(page).to have_link "いいね", href: favorites_plan_path(@user.id)
      end
      it "「一覧」があり、リンクの内容が正しい" do
        expect(page).to have_link "一覧", href: plans_path
      end
      it "「ログアウト」があり、リンクの内容が正しい" do
        expect(page).to have_link "ログアウト", href: users_sign_out_path
      end
      it "検索フォームが表示される" do
        expect(page).to have_field "keyword"
      end
      it "検索ボタンが表示される" do
        expect(page).to have_button "検索"
      end
    end
  end

  describe "ユーザーログアウトのテスト" do
    before do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in "user[email]", with: @user.email
      fill_in "user[password]", with: @user.password
      click_button "ログイン"
      click_link "ログアウト"
    end
    context "ログアウト機能テスト" do
      it "ログアウト後のリダイレクト先がトップ画面になっている" do
        expect(current_path).to eq '/'
      end
      it "ログアウト後ヘッダーに新規登録のリンクが存在する" do
        expect(page).to have_link "新規登録", href: new_user_registration_path
      end
    end
  end

end