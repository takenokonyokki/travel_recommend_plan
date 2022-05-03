# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ユーザーログイン前のテスト", type: :system do
  let(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }
  let!(:favorite) { create(:favorite, user: user, plan: plan) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe "投稿一覧画面のテスト" do
    before do
      visit plans_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq '/plans'
      end
      it "投稿されているリンク先が正しい" do
        expect(page).to have_link plan.title, href: plan_path(plan.id)
      end
    end

  end

end
