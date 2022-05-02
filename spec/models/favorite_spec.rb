# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "favoriteモデル", type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end
  describe '正常値と異常値の確認' do
    context 'likeモデルのバリデーション' do
      it "user_idとpaln_idがあれば保存できる" do
        expect(FactoryBot.create(:favorite)).to be_valid
      end
      it "plan_idが同じでもuser_idが違うと保存できる" do
        favorite = FactoryBot.create(:favorite)
        expect(FactoryBot.create(:favorite, plan_id: favorite.plan_id)).to be_valid
      end
      it "user_idが同じでもplan_idが違うと保存できる" do
        favorite = FactoryBot.create(:favorite)
        expect(FactoryBot.create(:favorite, user_id: favorite.user_id)).to be_valid
      end
    end
  end
end