# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "投稿詳細画面", type: :system do

  let!(:user) {FactoryBot.create(:user, email: "test@test.com", password: "Password01")}

  before do
    visit new_user_session_path
    fill_in "user[email]", with:  "test@test.com"
    fill_in "user[password]", with:"Password01"
    click_button "ログイン"
  end

  describe "自分の投稿詳細画面のテスト" do
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
      it "addressが表示される" do
        expect(page).to have_content content.address
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
      it "旅行プラン詳細の編集リンクが表示される" do
        expect(page).to have_link "編集", href: edit_plan_content_path(plan.id, content.id)
      end
      it "旅行プラン詳細の削除リンクが表示される" do
        expect(page).to have_link "削除", href: plan_content_path(plan.id, content.id)
      end
    end
  end

end