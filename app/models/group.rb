class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages

  validates :name, presence: true, uniqueness: true

  # モデルインスタンスメソッド
  def show_last_message
    if (last_message = messages.last).present?
      # 最後のメッセージが存在した場合
      # 文章が存在する場合は文章を、文章が存在しない場合は'画像が投稿されています'を表示する
      last_message.text? ? last_message.text : '画像が投稿されています。'
    else
      # 最後のメッセージが存在しなかった場合
      # まだメッセージはありません。を表示する
      'まだメッセージはありません。'
    end
  end
end
