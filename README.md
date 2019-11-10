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
|birth|date|null: false|
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
|postal|string|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|address|string|null: false|
|build|string||
|tel|string|null: false|
|user|referenes|null: false, foreign_key|

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|number|string|null: false|
|deadline_month|integer|null: false|
|deadline_year|integer|null: false|
|securitycode|integer|null: false|
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
|category_id|integer|null: false|
|delivery_id|integer|null: false|
|brand_id|integer|null: false|
|payment_id|integer|null: false|

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
|product_id|integer|null: false|

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|string|null: false|

## category_seizesテーブル
|Column|Type|Options|
|------|----|-------|
|size-id|integer|null: false|
|category_id|integer|null: false|




## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|method_payment|string|null: false|
|product_id|integer|null: false|
|point|integer||

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|user|references|null: false, foreign_key|

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key|
|comment|string||
|evaluation|string||
|product_id|integer|null: false|

## transactionテーブル
|Column|Type|Options|
|------|----|-------|
|exhibit_user_id|integer|null: false, foreign_key|
|buy_user_id|integer|null: false, foreign_key|
|message|text|null: false|

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|user|references|null: false, foreign_key|
|message|text|null: false|