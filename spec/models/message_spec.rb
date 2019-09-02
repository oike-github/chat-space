require 'rails_helper'
# テスト対象：Messageのモデル
RSpec.describe Message, type: :model do
  # createアクション実行時
  describe '#create' do
    # #######################################
    # 結果：messagesテーブルにレコードが登録できる
    # #######################################
    context 'can save' do

      # 正常系_01
      # パターン：text, imageの値が存在する場合
      # 期待値  ：なし
      it 'is valid with text' do
        expect(build(:message, image: nil)).to be_valid
      end

      # 正常系_02
      # パターン：textの値のみ存在する場合
      # 期待値  ：なし
      it 'is valid with image' do
        expect(build(:message, text: nil)).to be_valid
      end

      # 正常系_03
      # パターン：text, imageの値が存在する場合
      # 期待値  ：なし
      it 'is valid with text and image' do
        expect(build(:message)).to be_valid
      end
    end

    # #######################################
    # 結果：messagesテーブルにレコードが登録できない
    # #######################################
    context 'can not save' do
      # 異常系_01
      # パターン：text, imageの値が存在しない場合
      # 期待値  ：(エラーメッセージ："textを入力してください")
      it 'is invalid without text and image' do
        message = build(:message, text: nil, image: nil)
        message.valid?
        expect(message.errors[:text]).to include('を入力してください')
      end

      # 異常系_02
      # パターン：group_idの値が存在しない場合
      # 期待値  ：(エラーメッセージ："groupを入力してください")
      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include('を入力してください')
      end

      # 異常系_03
      # パターン：user_idの値が存在しない場合
      # 期待値  ：(エラーメッセージ："userを入力してください")
      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include('を入力してください')
      end
    end
  end
end
