import UIKit
import RealmSwift
import Alamofire

class FTHConfirmationViewController: UIViewController {
	var realm : Realm?
	
	override func viewDidLoad() {
		self.realm = try! Realm()
	}
	
	func updateLocalDatabase(_ records : [ String : (NSDate, Int) ]) {
		records.forEach { key, val in
			try! realm?.write {
				let foodStock = RealmFoodStock()
				foodStock.name = key
				foodStock.exdate = val.0
				foodStock.num = val.1
				realm?.add(foodStock)
			}
		}
		
		updateRemoteDatabase(records)
	}
	
	func updateRemoteDatabase(_ records : [ String : (NSDate, Int) ]) {
		let accessToken = getAccessToken()
		
		let user_items = records.map { key, val in
			[ "item_id" : "", "item_name" : key, "expire_date" : String(describing: val.0) ]
		}
		
		Alamofire.request("https://labs.goo.ne.jp/api/morph", method: .post, parameters: [
			"user_item": user_items
		], encoding: JSONEncoding.default, headers: [ "x-access-token" : accessToken ]).responseJSON { response in
			print("Status Code: \(response.result.isSuccess)")
		}
	}
	
	func getAccessToken() -> String {
		let ud = UserDefaults.standard
		return ud.object(forKey: "x-access-token") as! String
	}
}
