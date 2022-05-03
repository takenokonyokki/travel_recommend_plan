# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "旅行プラン投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "ログイン"
  end

  describe "旅行プラン投稿画面テスト1" do
    before do
      @plan = FactoryBot.build(:plan)
      visit new_plan_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/new'
      end
      it "「旅行プラン作成」と表示される" do
        expect(page).to have_content "旅行プラン作成"
      end
      it "titleフォームが表示される" do
        expect(page).to have_field "plan[title]"
      end
      it "travelフォームが表示される" do
        expect(page).to have_field "plan[travel]"
      end
      it "画像を選択フォームが表示される" do
        expect(page).to have_content "画像を選択"
      end
      it "旅行プラン詳細入力へ進むボタンが表示される" do
        expect(page).to have_button "旅行プラン詳細入力へ進む"
      end
    end
    context "投稿成功のテスト" do
      it "正しく投稿が登録され、リダイレクト先が旅行詳細画面になっている" do
        visit new_plan_path
        fill_in "plan[title]", with: @plan.title
        find("#plan_travel").find("option[value='hokkaido']").select_option
        page.attach_file("plan[image]", Rails.root + 'spec/factories/test.jpg')
        expect { click_button "旅行プラン詳細入力へ進む" }.to change(Plan.all, :count).by(1)
        expect(current_path).to eq new_plan_content_path(Plan.last)
      end
    end
    context "投稿失敗のテスト" do
      before do
        fill_in "plan[title]", with: ''
        find("#plan_travel").find("option[value='']").select_option
      end
      it "投稿されないのでカウントは上がらない" do
        expect { click_button "旅行プラン詳細入力へ進む" }.to change(Plan.all, :count).by(0)
      end
      it "リダイレクト先が、投稿画面になっている" do
        click_button "旅行プラン詳細入力へ進む"
        expect(current_path).to eq ('/plans')
      end
    end
  end

end