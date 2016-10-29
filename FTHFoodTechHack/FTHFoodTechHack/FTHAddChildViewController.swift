import UIKit
import RealmSwift
import FlatUIKit

class FTHAddChildViewController: UIViewController, UITextFieldDelegate, FUIAlertViewDelegate{

    let foodTextField = FUITextField()
    let numTextField = FUITextField()
    var dateTextField = FUITextField()
    static let textFieldLeftMargin = 30

    override func viewDidLoad() {
    
        self.view.backgroundColor = UIColor.white
        let foodLabel = UILabel(frame:CGRect(x: 30, y: 100, width: 80 , height: 50))
         foodLabel.textAlignment = NSTextAlignment.center

         foodLabel.text = "食材名"
        self.view.addSubview(foodLabel)
        
        foodTextField.frame = CGRectMake(foodLabel.frame.maxX, 100, 200 , 50)
        foodTextField.delegate = self
        foodTextField.textFieldColor = UIColor.clear
        foodTextField.backgroundColor = UIColor.white
        foodTextField.borderColor = UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        foodTextField.borderWidth = 2.0
        foodTextField.cornerRadius = 3.0
        
        foodTextField.layer.borderColor = UIColor.gray.cgColor
        foodTextField.layer.borderWidth = 1.0
        self.view.addSubview(foodTextField)
        
        let numLabel = UILabel(frame: CGRect(x: 30, y: foodLabel.frame.maxY + 10, width: 80 , height: 50))
        numLabel.textAlignment = NSTextAlignment.center
        numLabel.text = "価格"
        self.view.addSubview(numLabel)
        
        numTextField.frame = CGRectMake(foodLabel.frame.maxX,foodLabel.frame.maxY + 10, 200 , 50)
        numTextField.delegate = self
        numTextField.textFieldColor = UIColor.clear
        numTextField.borderColor = UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        numTextField.borderWidth = 2.0
        numTextField.cornerRadius = 3.0
        numTextField.layer.borderColor = UIColor.gray.cgColor
        numTextField.layer.borderWidth = 1.0
        self.view.addSubview(numTextField)
        
        let dateLabel = UILabel(frame: CGRect(x: 30, y: numLabel.frame.maxY + 10, width: 80 , height: 50))
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.text = "賞味期限"
        self.view.addSubview(dateLabel)
        
        dateTextField.frame = CGRectMake(foodLabel.frame.maxX, numLabel.frame.maxY + 10, 200 , 50)
        dateTextField.delegate = self
        dateTextField.textFieldColor = UIColor.clear
        dateTextField.borderColor = UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        dateTextField.borderWidth = 2.0
        dateTextField.cornerRadius = 3.0
        dateTextField.layer.borderColor = UIColor.gray.cgColor
        dateTextField.layer.borderWidth = 1.0
        self.view.addSubview(dateTextField)
        
        let myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: Selector(("changedDateEvent:")), for: UIControlEvents.valueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.date
        dateTextField.inputView = myDatePicker

        
        let trybutton = FUIButton()
        trybutton.frame = CGRectMake(foodLabel.frame.maxX, dateTextField.frame.maxY + 10, 100, 50)
        trybutton.buttonColor =  UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        trybutton.shadowColor = UIColor.red
        trybutton.shadowHeight = 3.0
        trybutton.cornerRadius = 6.0
        
        trybutton.titleLabel?.textColor = UIColor.black
        trybutton.setTitle("追加する", for: UIControlState())
        trybutton.addTarget(self, action: #selector(didTapAddButton), for:.touchUpInside)
        self.view.addSubview(trybutton)       
    }

    override func didReceiveMemoryWarning() {}
    
    
    func changedDateEvent(sender:AnyObject?){
        let dateSelecter: UIDatePicker = sender as! UIDatePicker
        self.dateTextField.text = self.stringFromDate(date: dateSelecter.date as NSDate, format: "yyyy年MM月dd日")
    }

    
    func didTapAddButton(sender: UIButton){
        let realm = try! Realm()
        let realmFood = RealmFood()
        realmFood.name = foodTextField.text!
        realmFood.date = NSDate()
        realmFood.price = 100
        
        try! realm.write{
            realm.add(realmFood)
        }
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
//    func changeLabelDate(date:NSDate) {
//        self.dateTextField.text = self.dateFromString(date: date)
//    }
//    
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
}
