import UIKit
import FlatUIKit

class FTHConfirmationSubView: UIView{
    var nameTextField:FUITextField?
    var dateTextField:FUITextField?
    var priceTextView: FUITextField?
    
    init () {
        super.init(frame:CGRect.zero)
    }
    init(frame: CGRect, name: String, date:NSDate, price:Int, nameTextField:FUITextField, dateTextField:FUITextField, priceTextView:FUITextField) {
        super.init(frame: frame)

        let textFieldLeftMargin = 30
        self.nameTextField = nameTextField
        self.nameTextField?.frame = CGRect(x:CGFloat(textFieldLeftMargin) , y:frame.minY, width:frame.size.width/4, height:frame.size.height)
        self.nameTextField?.textFieldColor = UIColor.white
        self.nameTextField?.text = name
        self.addSubview(self.nameTextField!)
        
        self.dateTextField = dateTextField
        self.dateTextField?.frame = CGRect(x:(self.nameTextField?.frame.maxX)! + 30, y:frame.minY, width:frame.size.width/4, height:frame.size.height)
        self.dateTextField?.textFieldColor = UIColor.white
        self.dateTextField?.text = self.stringFromDate(date: date as NSDate, format: "yyyy-MM-dd")//needed to implement convertet
        self.addSubview(self.dateTextField!)
        
        self.priceTextView = priceTextView
        self.priceTextView?.frame = CGRect(x:(self.dateTextField?.frame.maxX)! + 30, y:frame.minY, width:frame.size.width/4, height:frame.size.height)
        self.priceTextView?.textFieldColor = UIColor.white
        self.priceTextView?.text = String(price)
        self.addSubview(self.priceTextView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    
}
