import Foundation
//This class works for initialize Food data when user add new foods. Each food model has three properties(name, exdata, num) and also decrement exdata method. This information can be access from refreigerator class.
open class FTHFoodModel {
    var name:String = ""
    var date:NSDate = NSDate()
    var price = 0
    var id : Int? = nil
    
    init(){}
    
    //exdate shoudn't be int.
    init(name:String, date:NSDate, price:Int, id:Int){
        self.name = name
        self.date = date
        self.price = price
        self.id = id
    }
    
    init(object : RealmFood) {
        self.name = object.name
        self.date = object.date
        self.price = object.price
        self.id = object.id.value
    }
}
