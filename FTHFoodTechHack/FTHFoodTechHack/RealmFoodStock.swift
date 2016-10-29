import Foundation
import RealmSwift

class RealmFoodStock: Object {
    dynamic var name = ""
    dynamic var exdate = 0
    dynamic var price = 0
    let id = RealmOptional<Int>()

}
