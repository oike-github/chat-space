# README

# ChatSpaceのDB設計
<br>

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :groups, through: :group_users
- has_many :group_users
<br>

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|member_id|integer|null: false, foreign_key: true|
|message_id|integer|null: false, foreign_key: true|

### Association
- has_many :users, through: :group_member
- has_many :messages
<br>

## group_userテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user
<br>

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|test|text|null: true|
|image_id|text|null: true|
|group_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group
- belongs_to :image
<br>

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|filename|string|null: false|
|message_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :message