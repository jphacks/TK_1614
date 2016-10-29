import Foundation
import RealmSwift

open class FTHRefrigeratorModel :NSObject {
    
    var foodStocks:[FTHFoodModel] = []
    
    var expiringFoodStocks:[FTHFoodModel] = []
    var normalFoodStocks:[FTHFoodModel] = []
    
    override init () {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
        })
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()

        for food in realm.objects(RealmFood.self) {
            //add food to expiring if it will be dead in three days
            if food.date.timeIntervalSince(NSDate() as Date) < 60*60*24*3 {
                let newFood = FTHFoodModel(name: food.name, date: food.date,price: food.price)
                self.expiringFoodStocks.append(newFood)
            } else {
                let newFood = FTHFoodModel(name: food.name, date: food.date,price: food.price)
                self.normalFoodStocks.append(newFood)
            }
        }
    }
    
    open func addFoodByTyping(name:String, date:NSDate, price:Int){
        let realm = try! Realm()
        
        let realmFood = RealmFood()
        realmFood.name = name
        realmFood.date = date
        realmFood.price = price
        
        try! realm.write{
            realm.add(realmFood)
        }
    }
}
