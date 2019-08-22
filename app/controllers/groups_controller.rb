class GroupsController < ApplicationController
  # edit、updateアクションが呼ばれた場合アクション実行前にset_groupを実行する
  before_action :set_group, only: [:edit, :update]
  def index
  end

  def new
    # Groupモデルのインスタンスを作成する
    @group = Group.new
    # Groupモデルのインスタンスのuserに現在ログインしているユーザーを追加する
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      # groupテーブルへの登録が成功した場合
      # root_pathへオプション(通知用メッセージ)付きでリダイレクト
      redirect_to root_path, notice: 'グループを作成しました'
    else
      # groupテーブルへの登録が失敗した場合
      # newアクションのviewのみを表示
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      # groupテーブルへの更新が成功した場合
      # group_messages_pathへオプション(通知用メッセージ)付きでリダイレクト
      redirect_to group_messages_path(@group), notice: 'グループを編集しました'
    else
      # groupテーブルへの更新が失敗した場合
      # editアクションのviewのみを表示
      render :edit
    end
  end

  private
  def group_params
    # new.html.hamlからの値（グループ名、ユーザーID(配列)）
    params.require(:group).permit(:name, { :user_ids => [] })
  end

  def set_group
    # ログインユーザーのIDに紐付くレコードを取得する
    @group = Group.find(params[:id])
  end
end
