# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "planのテスト", type: :system do
  let!(:user) { create(:user, email: "test@test.com", password: "Password01") }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: "test@test.com"
    fill_in "user[password]", with: "Password01"
    click_button "ログイン"
  end

  describe "投稿一覧画面のテスト" do
    let!(:plan) { create(:plan, user: user) }
    before { visit plans_path }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans'
      end
      it "投稿されているリンク先が正しい" do
        expect(page).to have_link plan.title, href: plan_path(plan)
      end
    end
    context 'ユーザーが投稿をいいね、いいね解除ができる', js: true do
      it 'いいねができる' do
        find('#nolike-btn').click
        sleep 1
        expect(page).to have_selector '#liking-btn'
        expect(plan.favorites.count).to eq(1), xhr: true
      end
      it 'いいね解除ができる' do
        find('#nolike-btn').click
        find('#liking-btn').click
        expect(page).to have_selector '#nolike-btn'
        expect(plan.favorites.count).to eq(0), xhr: true
      end
    end
  end

  describe "マイページ画面のテスト" do
    let!(:plan) { create(:plan, user: user) }
    before { visit mypage_plans_path }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/mypage'
      end
      it "投稿されているリンク先が正しい" do
        expect(page).to have_link plan.title, href: plan_path(plan)
      end
      it "ユーザー名が表示され、そのリンク先が正しい" do
        expect(page).to have_link user.name, href: edit_user_registration_path
      end
    end

    context 'ユーザーが投稿をいいね、いいね解除ができる', js: true do
      it 'いいねができる' do
        find('#nolike-btn').click
        sleep 1
        expect(page).to have_selector '#liking-btn'
        expect(plan.favorites.count).to eq(1), xhr: true
      end
      it 'いいね解除ができる' do
        find('#nolike-btn').click
        find('#liking-btn').click
        expect(page).to have_selector '#nolike-btn'
        expect(plan.favorites.count).to eq(0), xhr: true
      end
    end
  end

  describe "いいね画面のテスト" do
    let!(:plan) { create(:plan, user: user) }
    let!(:favorite) { create(:favorite, user_id: user.id, plan_id: plan.id) }

    before do
      visit favorites_plan_path(plan.id)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/favorites'
      end
      it "投稿されているリンク先が正しい" do
        expect(page).to have_link plan.title, href: plan_path(plan)
      end
      it "ユーザー名が表示され、そのリンク先が正しい" do
        expect(page).to have_link user.name, href: edit_user_registration_path
      end
    end

    context 'ユーザーが投稿をいいね、いいね解除ができる', js: true do
      it 'いいね解除ができる' do
        find('#liking-btn').click
        expect(page).to have_selector '#nolike-btn'
        expect(plan.favorites.count).to eq(0), xhr: true
      end
    end
  end

  describe "旅行プラン投稿画面テスト" do
    let!(:plan) { create(:plan, user: user) }
    before { visit new_plan_path }

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
        fill_in "plan[title]", with: Faker::Lorem.characters(number: 10)
        find("#plan_travel").find("option[value='hokkaido']").select_option
        page.attach_file("plan[image]", Rails.root + 'spec/factories/test.jpg')
      end

      it "正しく投稿が登録される" do
        expect { click_button "旅行プラン詳細入力へ進む" }.to change(user.plans, :count).by(1)
      end
      it "リダイレクト先が旅行詳細投稿画面になっている" do
        click_button "旅行プラン詳細入力へ進む"
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

  describe "投稿詳細画面のテスト" do
    Geocoder.configure(lookup: :test, ip_lookup: :test)
      Geocoder::Lookup::Test.set_default_stub(
        [
          {
            'coordinates'  => [35.632896, 139.880394],
            'address'      => '〒279-0031 千葉県浦安市舞浜1-1',
            'country'      => '日本',
            'country_code' => 'JP'
          }
        ]
      )
    let(:plan) { FactoryBot.create(:plan, user: user) }
    let(:content) { FactoryBot.create(:content, plan: plan) }
    before { visit plan_path(content.plan_id) }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/' + content.plan_id.to_s
      end
      it "titleが表示される" do
        expect(page).to have_content plan.title
      end
      it "orderが表示される" do
        expect(page).to have_content content.order
      end
      it "hourが表示される" do
        expect(page).to have_content content.hour
      end
      it "minuteが表示される" do
        expect(page).to have_content content.minute
      end
      it "placeが表示される" do
        expect(page).to have_content content.place
      end
      it "explanationが表示される" do
        expect(page).to have_content content.explanation
      end
      it "nameが表示される" do
        expect(page).to have_content content.name
      end
      it "addressのリンクが表示される" do
        expect(page).to have_link "〒279-0031 千葉県浦安市舞浜1-1", href: map_plan_contents_path(plan.id, order: content.order)
      end
      it "telephonenumberが表示される" do
        expect(page).to have_content content.telephonenumber
      end
      it "accessが表示される" do
        expect(page).to have_content content.access
      end
      it "businesshoursが表示される" do
        expect(page).to have_content content.businesshours
      end
      it "priceが表示される" do
        expect(page).to have_content content.price
      end
      it "stay_timeが表示される" do
        expect(page).to have_content content.stay_time
      end
      it "rateが表示される" do
        expect(5.0).to eq content.rate
      end
      it "reservationが表示される" do
        expect(page).to have_content content.reservation
      end
      it "編集リンクが表示される" do
        expect(page).to have_link "編集", href: edit_plan_content_path(plan.id, content.id)
      end
      it "削除リンクが表示される" do
        expect(page).to have_link "削除", href: plan_content_path(plan.id, content.id)
      end
      it "行先を追加リンクが表示される" do
        expect(page).to have_link "行先を追加", href: new_plan_content_path(plan.id)
      end
      it "タイトルを編集リンクが表示される" do
        expect(page).to have_link "タイトルを編集", href: edit_plan_path(plan.id)
      end
      it "プランを削除リンクが表示される" do
        expect(page).to have_link "プランを削除", href: plan_path(plan.id)
      end
      it "みんなのコメントが表示される" do
        expect(page).to have_content "みんなのコメント"
      end
      it "コメント欄にユーザーの名前が表示される" do
        expect(page).to have_content user.name
      end
      it "コメントのフォームが表示される" do
        expect(page).to have_field "comment[comment]"
      end
      it "コメントの投稿ボタンが表示される" do
        expect(page).to have_button "投稿する"
      end
    end

    context 'addressのリンクのテスト' do
      it 'map画面に遷移する' do
        click_link '〒279-0031 千葉県浦安市舞浜1-1'
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/contents/' + 'map'
      end
    end

    context '編集リンクのテスト' do
      it '旅行プラン詳細の編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/contents/' + content.id.to_s + '/edit'
      end
      it 'タイトルの編集画面に遷移する' do
        click_link 'タイトルを編集'
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/edit'
      end
    end

    context '行先を追加リンクのテスト' do
      it '行先の情報入力画面に遷移する' do
        click_link '行先を追加'
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/contents/' + 'new'
      end
    end

    context '削除リンクのテスト' do
      it '旅行詳細が正しく削除される' do
        click_link '削除'
        expect(Content.where(id: content.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿詳細画面になっている' do
        expect(current_path).to eq '/plans/' + plan.id.to_s
      end
    end

    context 'プランを削除リンクのテスト' do
      it '旅行プランが正しく削除される' do
        click_link 'プランを削除'
        expect(Plan.where(id: plan.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        click_link 'プランを削除'
        expect(current_path).to eq plans_path
      end
    end

    context 'コメント投稿成功のテスト' do
      let!(:comment) { FactoryBot.create(:comment, user: user) }

      before do
        fill_in "comment[comment]", with: Faker::Lorem.sentence
      end

      it '正しくコメントが投稿できる' do
        expect { click_button "投稿する" }.to change(Comment.all, :count).by(1)
      end
      it 'リダイレクト先が投稿詳細画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/plans/' + plan.id.to_s
      end
    end

    context 'コメント投稿失敗のテスト' do
      let!(:comment) { FactoryBot.create(:comment, user: user) }

      before do
        fill_in "comment[comment]", with: ''
      end

      it '投稿されないのでカウントは上がらない' do
        expect { click_button "投稿する" }.to change(Comment.all, :count).by(0)
      end
      it 'リダイレクト先が投稿詳細画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/plans/' + plan.id.to_s
      end
    end
  end

  describe '旅行プラン投稿編集画面のテスト' do
    let(:plan) { create(:plan, user: user) }
    before { visit edit_plan_path(plan.id) }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/edit'
      end
      it "「旅行プラン編集」と表示される" do
        expect(page).to have_content "旅行プラン編集"
      end
      it "titleフォームが表示される" do
        expect(page).to have_field "plan[title]", with: plan.title
      end
      it "travelフォームが表示される" do
        expect(page).to have_field "plan[travel]", with: plan.travel
      end
      it "画像を選択フォームが表示される" do
        expect(page).to have_content "画像を選択"
      end
      it "編集ボタンが表示される" do
        expect(page).to have_button "編集"
      end
    end

    context '編集成功のテスト' do
      before do
        @plan_old_title = plan.title
        @plan_old_travel = find("option[value='hokkaido']").select_option
        fill_in "plan[title]", with: Faker::Lorem.characters(number: 10)
        find("#plan_travel").find("option[value='hokkaido']").select_option
        click_button '編集'
      end

      it 'titleが正しく更新される' do
        expect(plan.reload.title).not_to eq @plan_old_title
      end
      it 'travelが正しく更新される' do
        expect(plan.reload.travel).not_to eq @plan_old_travel
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/plans/' + plan.id.to_s
      end
    end
  end

  describe "ユーザー情報編集のテスト" do
    let!(:plan) { create(:plan, user: user) }
    before { visit edit_user_registration_path }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/users/edit'
      end
      it "「アカウント編集」と表示される" do
        expect(page).to have_content "アカウント編集"
      end
      it "nameフォームが表示される" do
        expect(page).to have_field "user[name]", with: user.name
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "user[email]", with: user.email
      end
      it "画像を選択フォームが表示される" do
        expect(page).to have_content "画像を選択"
      end
      it "編集ボタンが表示される" do
        expect(page).to have_button "編集"
      end
    end

    context '編集成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_email = user.email
        fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "user[email]", with: Faker::Internet.email
        click_button '編集'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
      end
      it 'リダイレクト先が、更新したマイページ画面になっている' do
        expect(current_path).to eq '/plans/mypage'
      end
    end
  end

  describe "投稿検索のテスト" do
    let!(:plan) { create(:plan, user: user) }
    before { visit plans_path }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans'
      end
      it "検索フォームが表示される" do
        expect(page).to have_field "keyword"
      end
      it "検索ボタンが表示される" do
        expect(page).to have_button "検索"
      end
      it "投稿されているリンク先が正しい" do
        expect(page).to have_link plan.title, href: plan_path(plan)
      end
    end

    context "検索キーワードにヒットしたとき" do
      before do
        fill_in "keyword", with: plan.title
        click_button '検索'
      end

      it "投稿されているリンク先が正しい" do
        expect(page).to have_link plan.title, href: plan_path(plan)
      end
    end

    context "検索キーワードにヒットしなかったとき" do
      before do
        fill_in "keyword", with: "???"
        click_button '検索'
      end

      it "検索結果はありませんが表示される" do
        expect(page).to have_content "検索結果はありません"
      end
    end
  end

end
