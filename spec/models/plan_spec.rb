# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Planモデル", type: :model do
  before do
    @plan = FactoryBot.build(:plan)
  end

  describe "旅行プランが作成" do
    context "旅行プラン作成がうまくできるとき" do
      it "内容に問題がない場合" do
        expect(@plan).to be_valid
      end
    end
    context "旅行プラン作成ができないとき" do
      it "titleが空だと保存できない" do
        @plan.title = ''
        @plan.valid?
        expect(@plan.errors[:title]).to include("タイトルを入れてください")
      end
      it "travelが空だと保存できない" do
        @plan.travel = ''
        @plan.valid?
        expect(@plan.errors[:travel]).to include("都道府県が選択されていません")
      end
    end
  end
end