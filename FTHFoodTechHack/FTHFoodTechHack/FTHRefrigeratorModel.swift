import Foundation
import RealmSwift

open class FTHRefrigeratorModel :NSObject {
    
    var foodStocks:[FTHFoodModel] = []
    
    var expiringFoodStocks:[FTHFoodModel] = []
    var normalFoodStocks:[FTHFoodModel] = []
    
    override init () {
        let realm = try! Realm()

        var count:Int
        count = 0
        for food in realm.objects(RealmFoodStock.self) {
            if count < 15{
                let newFood = FTHFoodModel(name:food.name, exdate: 0, price: 1)
                self.expiringFoodStocks.append(newFood)
            } else {
                let newFood = FTHFoodModel(name:food.name, exdate: 10, price: 1)
                self.normalFoodStocks.append(newFood)
            }
            count += 1
        }
    }
    
    open func addFoodByTyping(name:String, exdate:Int, price:Int){
        let realm = try! Realm()
        
        let realmFoodStock = RealmFoodStock()
        realmFoodStock.name = name
        realmFoodStock.exdate = exdate
        realmFoodStock.price = price
        
        
        try! realm.write{
            realm.add(realmFoodStock)
        }
    }
    
}
