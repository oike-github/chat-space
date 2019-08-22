class GroupsController < ApplicationController
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
  end

  private
  def group_params
    # new.html.hamlからの値（グループ名、）
    params.require(:group).permit(:name, { :user_ids => [] })
  end
end
