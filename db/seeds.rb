#親
## カテゴリー
lady, men = Category.create([{name: "レディース"}, {name: "メンズ"}])

## デリバリー
exhibit, purchase = Delivery.create([{responsibility: "送料込み(出品者負担)"}, {responsibility: "着払い(購入者負担)"}])


#子
## カテゴリー
lady_tops, lady_jacket = lady.children.create([{name: "トップス"}, {name: "ジャケット/アウター"}])
men_tops, men_jacket = men.children.create([{name: "トップス"}, {name: "ジャケット/アウター"}])

## デリバリー
exhibit_undecided, exhibit_rakuraku = exhibit.children.create([{responsibility: "未定"}, {responsibility: "らくらくメルカリ便"}])
purchase_undecided, purchase_kuroneko = purchase.children.create([{responsibility: "未定"}, {responsibility: "クロネコヤマト"}])


#孫
shirt_short, shirt_long = lady_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}])
shirt_short, shirt_long = men_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}])
tailored_jacket, collarless_jacket = lady_jacket.children.create([{name: "テーラードジャケット"}, {name: "ノーカラージャケット"}])
tailored_jacket, collarless_jacket = men_jacket.children.create([{name: "テーラードジャケット"}, {name: "ノーカラージャケット"}])
