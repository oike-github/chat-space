require 'rails_helper'

# messages_controllerのテスト
describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  # #################
  # indexアクション
  # #################
  describe '#index' do

    # ログインしている場合
    context 'log in' do
      # 共通処理
      before do
        # support/controller_macros.rbのlogin(user)にuserを渡しログインし、
        # indexアクションを実行する
        login user
        get :index, params: { group_id: group.id }
      end

      # @messageがMessageクラスのインスタンスかつ未保存である
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end

      # @messageがgroupと同一である
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      # indexのビューが表示される
      it 'redners index' do
        expect(response).to render_template :index
      end
    end

    # ログインしていない場合
    context 'not log in' do
      before do
        # get :index, params: { group_id: group.id }
        get :index, params: { group_id: group.id }
      end

      # リダイレクトでサインアップ画面へ遷移する
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  # #################
  # createアクション
  # #################
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    # ログインしている場合
    context 'log in' do
      # 共通処理
      before do
        login user
      end

      # メッセージが保存できる場合
      context 'can save' do
        subject {
          post :create,
          params: params
        }

        # メッセージが１件追加される
        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        # messagesのindex画面へ遷移する
        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      # メッセージの保存ができない場合
      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, text: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        # メッセージが追加されていない
        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        # indexのビューが表示されている
        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    # ログインしていない場合
    context 'not log in' do

      # サインアップ画面へ遷移する
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end