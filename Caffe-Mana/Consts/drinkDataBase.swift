import Foundation


let drinkData:Dictionary<String, DrinkData> = [
    "m1":DrinkData(drinkId: "m1",name: "モンスターエナジー", cafeine: 142, price: 200, volume: 355, fileName: "monsterEnergy"),
    "m2":DrinkData(drinkId: "m2",name: "モンスターエナジー(500ml)", cafeine: 200, price: 275, volume: 500, fileName: "monsterEnergy-large"),
    "m3":DrinkData(drinkId: "m3",name: "スーパーコーラ", cafeine: 142, price: 195, volume: 355, fileName: "monster-supercola"),
    "m4":DrinkData(drinkId: "m4",name: "リザーブウォーターメロン", cafeine: 142, price: 180, volume: 355, fileName: "monster-watermelon"),
    "m5":DrinkData(drinkId: "m5",name: "カオス", cafeine: 142, price: 190, volume: 355, fileName: "monster-chaos"),
    "m6":DrinkData(drinkId: "m6",name: "パイプラインパンチ", cafeine: 142, price: 200, volume: 355, fileName: "monster-pipelinepunch"),
    "m7":DrinkData(drinkId: "m7",name: "ロッシ", cafeine: 124, price: 200, volume: 355, fileName: "monster-rossi"),
    "m8":DrinkData(drinkId: "m8",name: "マンゴーロコ", cafeine: 142, price: 200, volume: 355, fileName: "monster-mango"),
    "m9":DrinkData(drinkId: "m9",name: "ウルトラ", cafeine: 140, price: 200, volume: 355, fileName: "monster-ultra"),
    "m10":DrinkData(drinkId: "m10",name: "ウルトラパラダイス", cafeine: 142, price: 200, volume: 355, fileName: "monster-ultraparadise"),
    "m11":DrinkData(drinkId: "m11",name: "アブソリュートゼロ", cafeine: 142, price: 200, volume: 355, fileName: "monster-absolutezero"),
    "m12":DrinkData(drinkId: "m12",name: "M3", cafeine: 140, price: 190, volume: 150, fileName: "monster-M3"),
    "r1":DrinkData(drinkId: "r1",name: "レッドブル(255ml)", cafeine: 80, price: 250, volume: 355, fileName: "redbull"),
    "r2":DrinkData(drinkId: "r2",name: "レッドブル(355ml)", cafeine: 114, price: 250, volume: 355, fileName: "redbull"),
    "r3":DrinkData(drinkId: "r3",name: "レッドブル(473ml)", cafeine: 151, price: 330, volume: 473, fileName: "redbull"),
    "r4":DrinkData(drinkId: "r4",name: "レッドエディション", cafeine: 80, price: 130, volume: 250, fileName: "redbull-red"),
    "r5":DrinkData(drinkId: "r5",name: "ブルーエディション", cafeine: 80, price: 150, volume: 250, fileName: "redbull-blue"),
    "r6":DrinkData(drinkId: "r6",name: "パープルエディション", cafeine: 80, price: 190, volume: 250, fileName: "redbull-purple"),
    "r7":DrinkData(drinkId: "r7",name: "イエローエディション", cafeine: 80, price: 175, volume: 250, fileName: "redbull-yello"),
    "r8":DrinkData(drinkId: "r8",name: "シュガーフリー", cafeine: 80, price: 170, volume: 250, fileName: "redbull-sugarfree"),
    "z1":DrinkData(drinkId: "z1",name: "ゾーン", cafeine: 150, price: 185, volume: 500, fileName: "zone"),
    "z2":DrinkData(drinkId: "z2",name: "ユートピア", cafeine: 75, price: 190, volume: 500, fileName: "zone-utopia"),
    "z3":DrinkData(drinkId: "z3",name: "ダイブ", cafeine: 75, price: 185, volume: 500, fileName: "zone-dive")
]

let addDrinkData = [
    [["m1", "m2", "m3", "m4"], ["m5", "m6", "m7", "m8"]],
    [["m9", "m10", "m11", "m12"], ["r1", "r2", "r3", "r4"]],
    [["r5", "r6", "r7", "r8"], ["z1", "z2", "z3"]]
]
