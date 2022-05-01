# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "commentモデル", type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe "コメント投稿" do
    context "コメント投稿がうまくできるとき" do
      it "内容に問題がない場合" do
        expect(@comment).to be_valid
      end
    end
    context "コメント投稿がうまくできないとき" do
      it "commentが空だと保存できない" do
        @comment.comment = ''
        @comment.valid?
        expect(@comment[:comment]).to eq ''
      end
    end
  end
end