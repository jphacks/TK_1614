import UIKit
import SwiftyJSON
import FlatUIKit
import Alamofire
import RealmSwift

class FTHConfirmationViewController: UIViewController {
    var realm: Realm?
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
        let textFieldHeight = 50
        for (key, val) in self.table {
            var fthConSubView = FTHConfirmationSubView(frame: CGRect(x: 0, y: index * textFieldHeight, width: Int(self.view.bounds.size.width), height: textFieldHeight), name: key, date: val.1, price: val.0, nameTextField: FUITextField(), dateTextField: FUITextField(), priceTextView: FUITextField())
            fthConSubView.dateTextField?.inputView = self.myDatePicker
            self.myScrollView.addSubview(fthConSubView)
            index += 1
        }
        let trybutton = FUIButton()
        trybutton.frame = CGRectMake(100 ,300, 100, 50)
        trybutton.buttonColor =  UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        trybutton.shadowColor = UIColor.red
        trybutton.shadowHeight = 3.0
        trybutton.cornerRadius = 6.0
        
        trybutton.titleLabel?.textColor = UIColor.black
        
        trybutton.setTitle("認証する", for: UIControlState())
        trybutton.addTarget(self, action: #selector(didTapConButton), for:.touchUpInside)
        self.view.addSubview(trybutton)

    }
    
    func didTapConButton (_ sender: UIButton){
        var records : [  String : (NSDate, Int, Int) ] = [:]
        
        for view in self.myScrollView.subviews{
            if let conview = view as? FTHConfirmationSubView {
                records[(conview.nameTextField?.text!)!] = (dateFromString(string:(conview.dateTextField?.text)!, format: "yyyy-MM-dd"),0,0)
            }
//            records[((view as! FTHConfirmationSubView).nameTextField?.text)!] = (dateFromString(string: ((view as! FTHConfirmationSubView).dateTextField?.text)!, format: "yyyy-MM-dd"),0,0)
            
        }
        
        updateRemoteDatabase(records)
    }
    
    func changedDateEvent(sender:AnyObject?, textField:FUITextField){
        let dateSelecter: UIDatePicker = sender as! UIDatePicker
        textField.text = self.stringFromDate(date: dateSelecter.date as NSDate, format: "yyyy-MM-dd")
    }
    
    
    func updateLocalDatabase(_ records : [ String : (Int, NSDate) ]) {
        records.forEach { key, val in
            try! realm?.write {
                let foodStock = RealmFood()
                foodStock.name = key
                foodStock.id = RealmOptional<Int>(val.0)
                foodStock.date = val.1
                realm?.add(foodStock)
            }
        }
    }
    // 二番目の仮IDの情報と三番目のpriceの情報は捨てる
    func updateRemoteDatabase(_ records : [ String : (NSDate, Int, Int) ]) {
        let accessToken = getAccessToken()
        
        let user_items = records.map { key, val in
            [ "item_id" : "", "item_name" : key, "expire_date" : String(describing: val.0) ]
        }
        
        Alamofire.request("https://app.uthackers-app.tk/item/add", method: .post, parameters: [
            "user_item": user_items
            ], encoding: JSONEncoding.default, headers: [ "x-access-token" : accessToken ]).responseJSON { response in
                print("Status Code: \(response.result.isSuccess)")
                
                guard let object = response.result.value else { return }
                let json = JSON(object)
                
                var records : [ String : (Int, NSDate) ] = [:]
                
                json["user_item"].arrayValue.forEach {
                    let name = $0["user_item"].string!
                    let date = self.dateFromString(string: $0["expire_date"].string!, format: "YYYY-MM-DD")
                    let user_item_id = Int($0["user_item_id"].string!)!
                    
                    records[name] = (user_item_id, date)
                }
                
                self.updateLocalDatabase(records)
        }
    }
    
    func getAccessToken() -> String {
        let ud = UserDefaults.standard
        return ud.object(forKey: "x-access-token") as! String
    }
    
    func stringFromDate(date: NSDate, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    
    func dateFromString(string: String, format: String) -> NSDate {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)! as NSDate
}
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
