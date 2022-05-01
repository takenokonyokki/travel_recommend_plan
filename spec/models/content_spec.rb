# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Contentモデル", type: :model do
  before do
    @content = FactoryBot.build(:content)
  end

  describe "行先の情報入力" do
    context "行先の情報入力がうまくできるとき" do
      it "内容に問題がない場合" do
        expect(@content).to be_valid
      end
    end
    context "行先の情報入力がうまくできないとき" do
      it "orderが半角数字以外だと保存できない" do
        @content.order = 'a'
        @content.valid?
        expect(@content.errors[:order]).to include("数字を入れてください")
      end
      it "hourが空だと保存できない" do
        @content.hour = ''
        @content.valid?
        expect(@content.errors[:hour]).to include("選択してください")
      end
      it "minuteが空だと保存できない" do
        @content.minute = ''
        @content.valid?
        expect(@content.errors[:minute]).to include("選択してください")
      end
      it "placeが空だと保存できない" do
        @content.place = ''
        @content.valid?
        expect(@content.errors[:place]).to include("行先のタイトルを入力してください")
      end
      it "explanationが空だと保存できない" do
        @content.explanation = ''
        @content.valid?
        expect(@content.errors[:explanation]).to include("行先についての説明を入力してください")
      end
      it "nameが空だと保存できない" do
        @content.name = ''
        @content.valid?
        expect(@content.errors[:name]).to include("名称を入力してください")
      end
      it "addressが空だと保存できない" do
        @content.address = ''
        @content.valid?
        expect(@content.errors[:address]).to include("住所を入力してください")
      end
      it "telephonenumberが空だと保存できない" do
        @content.telephonenumber = ''
        @content.valid?
        expect(@content.errors[:telephonenumber]).to include("電話番号を入力してください")
      end
      it "accessが空だと保存できない" do
        @content.access = ''
        @content.valid?
        expect(@content.errors[:access]).to include("アクセスを入力してください")
      end
      it "businesshoursが空だと保存できない" do
        @content.businesshours = ''
        @content.valid?
        expect(@content.errors[:businesshours]).to include("営業時間を入力してください")
      end
      it "reservationが空だと保存できない" do
        @content.reservation = ''
        @content.valid?
        expect(@content.errors[:reservation]).to include("予約について選択してください")
      end
      it "priceが空だと保存できない" do
        @content.price = ''
        @content.valid?
        expect(@content.errors[:price]).to include("料金を入力してください")
      end
      it "stay_timeが空だと保存できない" do
        @content.stay_time = ''
        @content.valid?
        expect(@content.errors[:stay_time]).to include("滞在時間を入力してください")
      end
      it "rateが空だと保存できない" do
        @content.rate = ''
        @content.valid?
        expect(@content.errors[:rate]).to include("評価を入力してください")
      end
    end
  end
end