#親
lady, men = Category.create([{name: "レディース"}, {name: "メンズ"}])

#子
lady_tops, lady_jacket = lady.children.create([{name: "トップス"}, {name: "ジャケット/アウター"}])
men_tops, men_jacket = men.children.create([{name: "トップス"}, {name: "ジャケット/アウター"}])

#孫
shirt_short, shirt_long = lady_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}])
shirt_short, shirt_long = men_tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}])
tailored_jacket, collarless_jacket = lady_jacket.children.create([{name: "テーラードジャケット"}, {name: "ノーカラージャケット"}])
tailored_jacket, collarless_jacket = men_jacket.children.create([{name: "テーラードジャケット"}, {name: "ノーカラージャケット"}])
