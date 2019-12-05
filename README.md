# DB設計


##  usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string||
|family_name|string|null: false| 
|first_name|string|null: false|
|family_name_cana|string|null: false|
|first_name_cana|string|null: false|
|birthday|date|null: false|
|telphone|string|null: false, unique: true|
|profile|text||
|image|string||
|point|integer||
|postal_code|string||
|prefecture|string||
|city|string||
|address|string||
|building|string||
### Association
- has_many :payments
- has_many :products
- has_many :likes
- has_many :comments
- has_many :evaluations
- has_many :sns_credentials, dependent: :destroy
- has_one :adress, dependent: :destroy
- has_one :card, dependent: :destroy

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_cana|string|null: false|
|first_name_cana|string|null: false|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|tel|string|null: false|
|user|references|null: false, foreign_key|
### Association
- belongs_to :user

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|card_id|string|null: false|
|customer_id|string|null: false|
### Association
- belongs_to :user

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string|unique: true|
|provider|string|unique: true|
|user|references|null: false, foreign_key|
### Association
- belongs_to :user



## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|information|text|null: false|
|price|integer|null: false|
|area|string|null: false|
|status|string|null: false|
|sending_days|string|null: false|
|profit|integer|null: false|
|selling_status|string|null: false|
|user|references|null: false, foreign_key|
|category|references|null: false, foreign_key|
|delivery|references|null: false, foreign_key|
|brand|references|null: false, foreign_key|
### Association
- has_one :evaluation
- has_one :payment
- has_many :likes, dependetnt: :destroy
- has_many :transactions
- has_many :messages
- has_many :images, dependent: :destroy
- belongs_to :users
- belongs_to :category
- belongs_to :delivery
- belongs_to :brand

## deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|responsibility|string|null: false|
|way|string|null: false|
### Association
- belongs_to :product

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|string|null: false|
### Association
- has_many :category_sizes
- has_many :categories, through: :category_sizes

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
### Association
- has_many :products

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|product|references|null: false, foreign_key|
### Association
- belongs_to :product

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|string|null: false|
### Association
- has_many :category_sizes
- has_many :sizes, through: :category_sizes

## category_sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|references|null: false, foreign_key|
|category|references|null: false, foreign_key|
### Association
- belongs_to :size
- belongs_to :category



## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|method_payment|string|null: false|
|product|references|null: false, foreign_key|
|point|integer||
### Association
- belongs_to :user
- belongs_to :product

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key|
|user|references|null: false, foreign_key|
### Association
- belongs_to :user
- belongs_to :product

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|comment|string||
|evaluation|string||
|product|references|null: false, foreign_key|
### Association
- belongs_to :user
- belongs_to :product

## transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|message|text|null: false|
|product|references|null: false, foreign_key|
### Association
- belongs_to :user
- belongs_to :product

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key|
|user|references|null: false, foreign_key|
|comment|text|null: false|
### Association
- belongs_to :user
- belongs_to :product