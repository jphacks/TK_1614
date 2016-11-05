import Foundation
import RealmSwift

class RealmFood: Object {
    dynamic var name = ""
    dynamic var date = NSDate()
    dynamic var price = 0
    var id = RealmOptional<Int>()
}
