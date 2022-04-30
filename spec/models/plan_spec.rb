# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plan, type: :model do
  before do
    @plan = FactoryBot.build(:plan)
    @user = FactoryBot.build(:user)
  end
  
  describe "旅行プランが作成" do
    context "旅行プラン作成がうまくできるとき" do
      it "内容に問題がない場合" do
        expect(@plan).to be_valid
      end
    end
  end
end