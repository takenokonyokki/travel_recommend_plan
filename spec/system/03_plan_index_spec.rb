# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe "投稿一覧", type: :system do
#   before do
#     @user = FactoryBot.create(:user)
#     visit new_user_session_path
#     fill_in "user[email]", with: @user.email
#     fill_in "user[password]", with: @user.password
#     click_button "ログイン"
#   end

#   describe "投稿一覧画面のテスト" do
#     before do
#       @plan = FactoryBot.create(:plan)
#       @favorite = FactoryBot.create(:favorite)
#       visit plans_path
#     end
#     context "表示内容の確認" do
#       it "URLが正しい" do
#         expect(current_path).to eq '/plans'
#       end
#       it "投稿されているリンク先が正しい" do
#         expect(page).to have_link @plan.title, href: plan_path(@plan.id)
#       end
#     end
#     context "投稿にいいねができる" do
#       it "いいねをする" do
#         click_link "0"
#         expect(@plan.favorites.count).to eq(1)
#       end
#       it "いいねを解除する" do
#         click_link "1"
#         expect(@plan.favorites.count).to eq(0)
#       end
#     end
#   end

# end