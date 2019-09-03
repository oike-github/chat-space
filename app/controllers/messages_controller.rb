class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    # 送信された情報を保持したmessageインスタンスを生成
    @message = @group.messages.new(message_params)
    if @message.save
      # messagesテーブルへの登録が成功した場合
      respond_to do |format|
        format.html
        format.json
      end
      # messages/index.html.hamlへインスタンス変数とオプション(通知用メッセージ)付きでリダイレクト
      # redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      # messagesテーブルへの登録が失敗した場合
      # フラッシュメッセージに設定したアラートメッセージを表示
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      # indexアクションのviewを表示
      render :index
    end
  end

  private

  def message_params
    # paramsに格納されているmessageオブジェクトのtext、imageとuser_idのみを抽出
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_group
    # グループテーブル.グループIDに紐付くレコードを取得
    @group = Group.find(params[:group_id])
  end
end
