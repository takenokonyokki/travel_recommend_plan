# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ユーザーログイン後のテスト", type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "ログイン"
  end

  describe "ログインしているときのヘッダーのテスト" do
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

  describe "投稿一覧画面のテスト" do
    before do
      @plan = FactoryBot.create(:plan)
      @favorite = FactoryBot.create(:favorite)
      visit plans_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans'
      end
      it "投稿されているリンク先が正しい" do
        expect(page).to have_link @plan.title, href: plan_path(@plan.id)
      end
    end
    context "投稿にいいねができる" do
      it "いいねをする" do
        click_link "0"
        expect(@plan.favorites.count).to eq(1)
      end
      it "いいねを解除する" do
        click_link "1"
        expect(@plan.favorites.count).to eq(0)
      end
    end
  end

  describe "旅行プラン投稿画面テスト" do
    before do
      @plan = FactoryBot.build(:plan)
      # @content = FactoryBot.build(:content)
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
      before do
        fill_in "plan[title]", with: @plan.title
        find("#plan_travel").find("option[value='hokkaido']").select_option
        page.attach_file("plan[image]", Rails.root + 'spec/factories/test.jpg')
      end
      it "正しく投稿が登録される" do
        expect { click_button "旅行プラン詳細入力へ進む" }.to change(Plan.all, :count).by(1)
      end
      it "リダイレクト先が行先情報入力画面になっている" do
        click_button "旅行プラン詳細入力へ進む"
        expect(current_path).to eq new_plan_content_path(@plan.id) #エラー
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

  describe "旅行プラン詳細入力画面のテスト" do
    before do
      @plan = FactoryBot.build(:plan)
      @content = FactoryBot.build(:content)
      visit new_plan_content_path(@plan.id) #エラー
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/1/contents/new'
      end
      it "行先の情報を入力が表示される" do
        expect(page).to have_content "行先の情報を入力"
      end
      it "orderフォームが表示される" do
        expect(page).to have_field "content[order]"
      end
      it "hourフォームが表示される" do
        expect(page).to have_field "content[hour]"
      end
      it "minuteフォームが表示される" do
        expect(page).to have_field "content[minute]"
      end
      it "placeフォームが表示される" do
        expect(page).to have_field "content[place]"
      end
      it "画像を選択フォームが表示される" do
        expect(page).to have_content "画像を選択"
      end
      it "explanationフォームが表示される" do
        expect(page).to have_field "content[explanation]"
      end
      it "基本情報が表示される" do
        expect(page).to have_content "基本情報"
      end
      it "nameフォームが表示される" do
        expect(page).to have_field "content[name]"
      end
      it "addressフォームが表示される" do
        expect(page).to have_field "content[address]"
      end
      it "telephonenumberフォームが表示される" do
        expect(page).to have_field "content[telephonenumber]"
      end
      it "accessフォームが表示される" do
        expect(page).to have_field "content[access]"
      end
      it "businesshoursフォームが表示される" do
        expect(page).to have_field "content[businesshours]"
      end
      it "reservationフォームが表示される" do
        expect(page).to have_field "content[reservation]"
      end
      it "priceフォームが表示される" do
        expect(page).to have_field "content[price]"
      end
      it "stay_timeフォームが表示される" do
        expect(page).to have_field "content[stay_time]"
      end
      it "rateフォームが表示される" do
        expect(page).to have_field "content[rate]"
      end
      it "次の行先ボタンが表示される" do
        expect(page).to have_button "次の行先"
      end
      it "終了ボタンが表示される" do
        expect(page).to have_button "終了"
      end
    end
    context "次の行先を選択したときの投稿成功のテスト" do
      before do
        fill_in "content[order]", with: @content.order
        fill_in "content[hour]", with: @content.hour
        fill_in "content[minute]", with: @content.minute
        fill_in "content[place]", with: @content.place
        page.attach_file("plan[image]", Rails.root + 'spec/factories/test.jpg')
        fill_in "content[explanation]", with: @content.explanation
        fill_in "content[name]", with: @content.name
        fill_in "content[address]", with: @content.address
        fill_in "content[telephonenumber]", with: @content.telephonenumber
        fill_in "content[access]", with: @content.access
        fill_in "content[businesshours]", with: @content.businesshours
        find("#content_reservation").find("option[value='完全予約制']").select_option
        fill_in "content[price]", with: @content.price
        fill_in "content[stay_time]", with: @content.stay_time
        page.all('img')[4].click
      end
      it "正しく投稿が登録される" do
        expect { click_button "次の行先" }.to change(Content.all, :count).by(1)
      end
      it "リダイレクト先が行先情報入力画面になっている" do
        click_button "次の行先"
        expect(current_path).to eq new_plan_content_path(@plan.id) #エラー
      end
    end
    context "終了を選択したときの投稿成功のテスト" do
      before do
        fill_in "content[order]", with: @content.order
        fill_in "content[hour]", with: @content.hour
        fill_in "content[minute]", with: @content.minute
        fill_in "content[place]", with: @content.place
        page.attach_file("plan[image]", Rails.root + 'spec/factories/test.jpg')
        fill_in "content[explanation]", with: @content.explanation
        fill_in "content[name]", with: @content.name
        fill_in "content[address]", with: @content.address
        fill_in "content[telephonenumber]", with: @content.telephonenumber
        fill_in "content[access]", with: @content.access
        fill_in "content[businesshours]", with: @content.businesshours
        find("#content_reservation").find("option[value='完全予約制']").select_option
        fill_in "content[price]", with: @content.price
        fill_in "content[stay_time]", with: @content.stay_time
        page.all('img')[4].click
      end
      it "正しく投稿が登録される" do
        expect { click_button "終了" }.to change(Content.all, :count).by(1)
      end
      it "リダイレクト先が投稿の詳細画面になっている" do
        click_button "終了"
        expect(current_path).to eq plan_path(@plan.id) #エラー
      end
    end
    context "投稿失敗のテスト" do
      before do
        fill_in "content[order]", with: ''
        fill_in "content[hour]", with: ''
        fill_in "content[minute]", with: ''
        fill_in "content[place]", with: ''
        fill_in "content[explanation]", with: ''
        fill_in "content[name]", with: ''
        fill_in "content[address]", with: ''
        fill_in "content[telephonenumber]", with: ''
        fill_in "content[access]", with: ''
        fill_in "content[businesshours]", with: ''
        find("#content_reservation").find("option[value='']").select_option
        fill_in "content[price]", with: ''
        fill_in "content[stay_time]", with: ''
        fill_in "content[rate]", with: ''
      end
      it "投稿されないのでカウントは上がらない" do
        expect { click_button "次の行先" }.to change(Content.all, :count).by(0)
      end
      it "リダイレクト先が行先情報入力画面になっている" do
        click_button "次の行先"
        expect(current_path).to eq ('/plans/1/contents')
      end
    end
  end

end