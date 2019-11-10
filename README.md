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
|profile|text||
|image|string||
|point|integer||

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_cana|string|null: false|
|first_name_cana|string|null: false|
|postal_code|string|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|tel|string|null: false|
|user|referenes|null: false, foreign_key|

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|number|string|null: false|
|deadline_month|integer|null: false|
|deadline_year|integer|null: false|
|security_code|integer|null: false|
|user|references|null: false, foreign_key|

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|credit|references|null: false, foreign_key|
|customer_id|integer|null: false|

## phone_numbersテーブル
|Column|Type|Options|
|------|----|-------|
|tel|string|null: false|
|user|references|null: false, foreign_key|

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string|unique: true|
|provider|string|unique: true|
|user|references|null: false, foreign_key|




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
|payment|references|null: false, foreign_key|

## deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|responsibility|string|null: false|
|way|string|null: false|

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|string|null: false|

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|product|references|null: false, foreign_key|

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|string|null: false|

## category_sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|references|null: false, foreign_key|
|category|references|null: false, foreign_key|




## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|method_payment|string|null: false|
|product|references|null: false, foreign_key|
|point|integer||

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key|
|user|references|null: false, foreign_key|

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|comment|string||
|evaluation|string||
|product|references|null: false, foreign_key|

## transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|exhibit_user_id|integer|null: false, foreign_key|
|user|references|null: false, foreign_key|
|message|text|null: false|
|product_id|integer|null: false|

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|user|references|null: false, foreign_key|
|message|text|null: false|