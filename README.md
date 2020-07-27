# README

## アプリ名
店長チャット

## アプリ概要
メッセージが投稿できる掲示板のようなチャットアプリです。

## 本番環境
* インフラ
AWS
* テストアカウント
ゲストアカウントをご用意しております。

## 制作背景
日本には現在約100万店舗の小売店が存在しております。すると必然的に店の長、すなわち店長も同数いると考えられます。私も以前までその100万人の一人でした。そして自身の経験から、「店長ならではの喜怒哀楽を気軽に掲示板感覚で共有できるツールがあればいいのに」と思い立ちこのアプリを制作いたしました。

## 機能一覧
![image](https://user-images.githubusercontent.com/63778345/88500782-a848a080-d004-11ea-85be-845d8206cfc1.png)
* ユーザー登録機能
* ゲスト登録機能
* メッサージ投稿機能
* グループ作成機能
* グループ検索機能

## 一押しポイント
* ゲスト機能によって、ユーザーフレンドリーなログインができます。
* 直感的なグループ検索、グループ一覧の認識ができます。
* メッセージはリロードなしで投稿でき、登校後は最新のメッセージまで自動でスクロールします。

## 課題や今後実装したい機能
* 現状だと店長専用アプリになっているので、もっと幅広い職位に対応することができたのではないか。
* グループ検索、グループ一覧の表示はもっとわかりやすく、直感的なUI/UXにできるはず。

## 技術一覧
* フロント  
HTML,SCSS,jQuery
* バックエンド  
Ruby,Rails  
* DB  
MySQL
* インフラ  
AWS

## DB設計

**messagesテーブル**

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group


**usersテーブル**

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :messages
- has_many :groups, through: :group_users
- has_many :group_users

 

**groupsテーブル**

|Column|Type|Options|
|------|----|-------|
|group_name|string|null: false, unique: true|

### Association
- has_many :messages
- has_many :users, through: :group_users
- has_many :group_users

 

**group_usersテーブル**

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group
