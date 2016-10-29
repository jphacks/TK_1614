import Foundation

//This class works for initialize Food data when user add new foods. Each food model has three properties(name, exdata, num) and also decrement exdata method. This information can be access from refreigerator class.
open class FTHFoodModel {
    var name:String = ""
    var exdate:Int = 0
    var num :Int = 0
    
    init(){}
    
    //exdate shoudn't be int.
    init(name:String, exdate:Int, num:Int){
        self.name = name
        self.exdate = exdate
        self.num = num
    }
    
    func decrementExData() {
        if self.exdate > 0 {
            self.exdate -= 1
        }
        
    }
}