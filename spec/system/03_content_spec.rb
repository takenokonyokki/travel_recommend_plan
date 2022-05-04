# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "contentのテスト", type: :system do
  let!(:user) { create(:user, email: "test@test.com", password: "Password01") }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: "test@test.com"
    fill_in "user[password]", with: "Password01"
    click_button "ログイン"
  end

  describe "旅行プラン詳細入力画面のテスト" do
    let(:plan) { FactoryBot.create(:plan, user: user) }
    let!(:content) { FactoryBot.create(:content, plan: plan) }
    before { visit new_plan_content_path(plan.id) }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/contents/new'
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
        expect(page).to have_selector "#star"
      end
      it "次の行先ボタンが表示される" do
        expect(page).to have_button "次の行先"
      end
      it "終了ボタンが表示される" do
        expect(page).to have_button "終了"
      end
    end

    context "投稿成功のテスト" do
      before do
        fill_in "content[order]", with: content.order
        select(value = "17", from: "content[hour]")
        select(value = "00", from: "content[minute]")
        fill_in "content[place]", with: content.place
        page.attach_file("content[image]", Rails.root + 'spec/factories/test.jpg')
        fill_in "content[explanation]", with: content.explanation
        fill_in "content[name]", with: content.name
        fill_in "content[address]", with: content.address
        fill_in "content[telephonenumber]", with: content.telephonenumber
        fill_in "content[access]", with: content.access
        fill_in "content[businesshours]", with: content.businesshours
        find("#content_reservation").find("option[value='完全予約制']").select_option
        fill_in "content[price]", with: content.price
        fill_in "content[stay_time]", with: content.stay_time
        first('input#review_star', visible: false).set("5")
        # fill_in "review_star", with: @content.rate, visible: false
      end
      it "次の行先を選択し、正しく投稿が登録される" do
        expect { click_button "次の行先" }.to change(Content.all, :count).by(1)
      end
      it "次の行先を選択した後、リダイレクト先が行先情報入力画面になっている" do
        click_button "次の行先"
        expect(current_path).to eq new_plan_content_path(plan.id)
      end
      it "終了を選択し、正しく投稿が登録される" do
        expect { click_button "終了" }.to change(Content.all, :count).by(1)
      end
      it "終了を選択した後、リダイレクト先が投稿詳細画面になっている" do
        click_button "終了"
        expect(current_path).to eq plan_path(plan.id)
      end
    end

    context "投稿失敗のテスト" do
      before do
        fill_in "content[order]", with: ''
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
      end
      it "投稿されないのでカウントは上がらない" do
        expect { click_button "次の行先" }.to change(Content.all, :count).by(0)
      end
      it "リダイレクト先が行先情報入力画面になっている" do
        click_button "次の行先"
        expect(current_path).to eq ('/plans/' + plan.id.to_s + '/contents')
      end
    end
  end

  describe '旅行プラン詳細入力編集画面のテスト' do
    let(:plan) { FactoryBot.create(:plan, user: user) }
    let(:content) { FactoryBot.create(:content, plan: plan) }
    before { visit edit_plan_content_path(plan.id, content.id) }

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/' + plan.id.to_s + '/contents/' + content.id.to_s + '/edit'
      end
      it "行先の情報を編集が表示される" do
        expect(page).to have_content "行先の情報を編集"
      end
      it "orderフォームが表示される" do
        expect(page).to have_field "content[order]", with: content.order
      end
      it "hourフォームが表示される" do
        expect(page).to have_field "content[hour]", with: content.hour
      end
      it "minuteフォームが表示される" do
        expect(page).to have_field "content[minute]", with: content.minute
      end
      it "placeフォームが表示される" do
        expect(page).to have_field "content[place]", with: content.place
      end
      it "画像を選択フォームが表示される" do
        expect(page).to have_content "画像を選択"
      end
      it "explanationフォームが表示される" do
        expect(page).to have_field "content[explanation]", with: content.explanation
      end
      it "基本情報が表示される" do
        expect(page).to have_content "基本情報"
      end
      it "nameフォームが表示される" do
        expect(page).to have_field "content[name]", with: content.name
      end
      it "addressフォームが表示される" do
        expect(page).to have_field "content[address]", with: content.address
      end
      it "telephonenumberフォームが表示される" do
        expect(page).to have_field "content[telephonenumber]", with: content.telephonenumber
      end
      it "accessフォームが表示される" do
        expect(page).to have_field "content[access]", with: content.access
      end
      it "businesshoursフォームが表示される" do
        expect(page).to have_field "content[businesshours]", with: content.businesshours
      end
      it "reservationフォームが表示される" do
        expect(page).to have_field "content[reservation]", with: content.reservation
      end
      it "priceフォームが表示される" do
        expect(page).to have_field "content[price]", with: content.price
      end
      it "stay_timeフォームが表示される" do
        expect(page).to have_field "content[stay_time]", with: content.stay_time
      end
      it "rateフォームが表示される" do
        expect(page).to have_selector "#star"
      end
      it "編集ボタンが表示される" do
        expect(page).to have_button "編集"
      end
    end

    context '編集成功のテスト' do
      before do
        @content_old_order = fill_in "content[order]", with: content.order
        @content_old_hour = select(value = "17", from: "content[hour]")
        @content_old_minute = select(value = "00", from: "content[minute]")
        @content_old_place = fill_in "content[place]", with: content.place
        @content_old_explanation = fill_in "content[explanation]", with: content.explanation
        @content_old_name = fill_in "content[name]", with: content.name
        @content_old_address = fill_in "content[address]", with: content.address
        @content_old_telephonenumber = fill_in "content[telephonenumber]", with: content.telephonenumber
        @content_old_access = fill_in "content[access]", with: content.access
        @content_old_businesshours = fill_in "content[businesshours]", with: content.businesshours
        @content_old_reservation = find("#content_reservation").find("option[value='完全予約制']").select_option
        @content_old_price = fill_in "content[price]", with: content.price
        @content_old_stay_time = fill_in "content[stay_time]", with: content.stay_time
        @content_old_rate = first('input#review_star', visible: false).set("5")
        click_button '編集'
      end

      it 'orderが正しく更新される' do
        expect(content.reload.order).not_to eq @content_old_order
      end
      it 'hourが正しく更新される' do
        expect(content.reload.hour).not_to eq @content_old_hour
      end
      it 'minuteが正しく更新される' do
        expect(content.reload.minute).not_to eq @content_old_minute
      end
      it 'placeが正しく更新される' do
        expect(content.reload.place).not_to eq @content_old_place
      end
      it 'explanationが正しく更新される' do
        expect(content.reload.explanation).not_to eq @content_old_explanation
      end
      it 'nameが正しく更新される' do
        expect(content.reload.name).not_to eq @content_old_name
      end
      it 'addressが正しく更新される' do
        expect(content.reload.address).not_to eq @content_old_address
      end
      it 'telephonenumberが正しく更新される' do
        expect(content.reload.telephonenumber).not_to eq @content_old_telephonenumber
      end
      it 'accessが正しく更新される' do
        expect(content.reload.access).not_to eq @content_old_access
      end
      it 'businesshoursが正しく更新される' do
        expect(content.reload.businesshours).not_to eq @content_old_businesshours
      end
      it 'reservationが正しく更新される' do
        expect(content.reload.reservation).not_to eq @content_old_reservation
      end
      it 'priceが正しく更新される' do
        expect(content.reload.price).not_to eq @content_old_price
      end
      it 'stay_timeが正しく更新される' do
        expect(content.reload.stay_time).not_to eq @content_old_stay_time
      end
      it 'rateが正しく更新される' do
        expect(content.reload.rate).not_to eq @content_old_rate
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq plan_path(plan.id)
      end
    end
  end

end