# DB設計


##  usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|family_name|string|null: false| 
|first_name|string|null: false|
|family_name_cana|string|null: false|
|first_name_cana|string|null: false|
|birth|string|null: false|
|uid|references|primary_key: true, unique: true|
|provide|integer|
|image|string||
|point|integer||

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_cana|string|null: false|
|first_name_cana|string|null: false|
|postal|integer|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|address|integer|null: false|
|build|string|null: false|
|tel|integer|null: false|
|user_id|integer|null: false, foreign_key|

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|deadline|integer|null: false|
|securitycode|integer|null: false, unique: true|
|user_id|integer|null: false, foreign_key|

## phone_numbersテーブル
|Column|Type|Options|
|------|----|-------|
|tel|integer|null: false|
|user_id|integer|null: false, foreign_key|




## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|information|string|null: false|
|price|integer|null: false|
|area|string|null: false|
|status|string|null: false|
|sending_days|integer|null: false|
|profit|integer|null: false|
|selling_status|string|null: false|
|user_id|integer|null: false, foreign_key|
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
|name|string||

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
|buyer|string||
|method_payment|string|null: false|
|produck_id|integer|null: false|
|point|integer||

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|user_id|integer|null: false, foreign_key|

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|exhibit_user_id|integer|null: false, foreign_key|
|buy_user_id|integer|null: false|
|comment|string||
|evaluation|string||
|product_id|integer|null: false|

## transactionテーブル
|Column|Type|Options|
|------|----|-------|
|exhibit_user_id|integer|null: false, foreign_key|
|buy_user_id|integer|null: false, foreign_key|
|message|string||

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false|
|user_id|integer|null: false|
|message|string|null: false|