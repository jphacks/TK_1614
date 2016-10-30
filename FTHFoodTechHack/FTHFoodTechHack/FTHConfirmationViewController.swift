import UIKit
import SwiftyJSON
import FlatUIKit
import Alamofire
import RealmSwift

class FTHConfirmationViewController: UIViewController {
    var realm : Realm?
    var myScrollView: UIScrollView!
    var table : [ String : (Int, NSDate, Int) ]
    var myDatePicker : UIDatePicker
    
    init(table: [ String : (Int, NSDate, Int)]) {
        self.table = table
        print(self.table)
        let myDatePicker = UIDatePicker()
        self.myDatePicker = myDatePicker
        super.init(nibName:nil, bundle: nil)
        self.myDatePicker.addTarget(self, action: #selector(changedDateEvent), for: UIControlEvents.valueChanged)
        self.myDatePicker.datePickerMode = UIDatePickerMode.date
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        self.realm = try! Realm()
        super.viewDidLoad()
        myScrollView = UIScrollView()
        myScrollView.backgroundColor = UIColor.white
        myScrollView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        myScrollView.contentSize = CGSize(width:self.view.frame.size.width, height:2000)
        self.view.addSubview(myScrollView)
        
        var index = 0
        let textFieldHeight = 100
        for (key, val) in self.table {
            var fthConSubView = FTHConfirmationSubView(frame: CGRect(x: 0, y: index * textFieldHeight, width: Int(self.view.bounds.size.width), height: textFieldHeight), name: key, date: val.1, price: val.0, nameTextField: FUITextField(), dateTextField: FUITextField(), priceTextView: FUITextField())
            fthConSubView.dateTextField?.inputView = self.myDatePicker
            self.myScrollView.addSubview(fthConSubView)
            index += 1
        }
    }
    
    func changedDateEvent(sender:AnyObject?, textField:FUITextField){
        let dateSelecter: UIDatePicker = sender as! UIDatePicker
        textField.text = self.stringFromDate(date: dateSelecter.date as NSDate, format: "yyyy-MM-dd")
    }
    
    func dateFromString(string: String, format: String) -> NSDate {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)! as NSDate
    }
    
    func stringFromDate(date: NSDate, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    
    func updateLocalDatabase(_ records : [ String : (NSDate, Int) ]) {
        records.forEach { key, val in
            try! realm?.write {
                let foodStock = RealmFood()
                foodStock.name = key
                foodStock.date = val.0
                foodStock.price = val.1
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
