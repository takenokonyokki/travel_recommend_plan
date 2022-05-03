require 'rails_helper'

RSpec.describe "旅行プラン詳細入力画面", type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in "user[email]", with: @user.email
    fill_in "user[password]", with: @user.password
    click_button "ログイン"
  end

  describe "旅行プラン詳細入力画面のテスト1" do
    before do
      @plan = FactoryBot.create(:plan)
      @content = FactoryBot.build(:content)
      visit new_plan_content_path(@plan.id)
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans/' + @plan.id.to_s + '/contents/new'
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
  end

  describe "旅行プラン詳細入力画面のテスト2" do
    before do
      @plan = FactoryBot.create(:plan)
      @content = FactoryBot.build(:content)
      visit new_plan_content_path(@plan.id)
    end
    context "次の行先を選択したときの投稿成功のテスト" do
      it "正しく投稿が登録され、リダイレクト先が行先情報入力画面になっている" do
        fill_in "content[order]", with: @content.order
        select(value = "17", from: "content[hour]")
        select(value = "00", from: "content[minute]")
        fill_in "content[place]", with: @content.place
        page.attach_file("content[image]", Rails.root + 'spec/factories/test.jpg')
        fill_in "content[explanation]", with: @content.explanation
        fill_in "content[name]", with: @content.name
        fill_in "content[address]", with: @content.address
        fill_in "content[telephonenumber]", with: @content.telephonenumber
        fill_in "content[access]", with: @content.access
        fill_in "content[businesshours]", with: @content.businesshours
        find("#content_reservation").find("option[value='完全予約制']").select_option
        fill_in "content[price]", with: @content.price
        fill_in "content[stay_time]", with: @content.stay_time
        first('input#review_star', visible: false).set("5")
        # fill_in "review_star", with: @content.rate, visible: false
        expect { click_button "次の行先" }.to change(Content.all, :count).by(1)
        expect(current_path).to eq new_plan_content_path(@plan.id)
      end
    end
  end

  describe "旅行プラン詳細入力画面のテスト3" do
    before do
      @plan = FactoryBot.create(:plan)
      @content = FactoryBot.build(:content)
      visit new_plan_content_path(@plan.id)
    end
    context "終了を選択したときの投稿成功のテスト" do
      it "正しく投稿が登録され、リダイレクト先が投稿の詳細画面になっている" do
        fill_in "content[order]", with: @content.order
        select(value = "17", from: "content[hour]")
        select(value = "00", from: "content[minute]")
        fill_in "content[place]", with: @content.place
        page.attach_file("content[image]", Rails.root + 'spec/factories/test.jpg')
        fill_in "content[explanation]", with: @content.explanation
        fill_in "content[name]", with: @content.name
        fill_in "content[address]", with: @content.address
        fill_in "content[telephonenumber]", with: @content.telephonenumber
        fill_in "content[access]", with: @content.access
        fill_in "content[businesshours]", with: @content.businesshours
        find("#content_reservation").find("option[value='完全予約制']").select_option
        fill_in "content[price]", with: @content.price
        fill_in "content[stay_time]", with: @content.stay_time
        first('input#review_star', visible: false).set("5")
        expect { click_button "終了" }.to change(Content.all, :count).by(1)
        expect(current_path).to eq plan_path(@plan.id)
      end
    end
  end

  describe "旅行プラン詳細入力画面のテスト4" do
    before do
      @plan = FactoryBot.create(:plan)
      @content = FactoryBot.build(:content)
      visit new_plan_content_path(@plan.id)
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
    context "投稿失敗のテスト" do
      it "投稿されないのでカウントは上がらない" do
        expect { click_button "次の行先" }.to change(Content.all, :count).by(0)
      end
      it "リダイレクト先が行先情報入力画面になっている" do
        click_button "次の行先"
        expect(current_path).to eq ('/plans/' + @plan.id.to_s + '/contents')
      end
    end
  end

end