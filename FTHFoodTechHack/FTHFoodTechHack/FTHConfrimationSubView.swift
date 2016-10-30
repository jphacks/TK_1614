import UIKit
import FlatUIKit

class FTHConfirmationSubView: UIView{
    var nameTextField:FUITextField?
    var dateTextField:FUITextField?
    var priceTextView: FUITextField?
    
    init(frame: CGRect, name: String, date:NSData, price:Int, nameTextField:FUITextField, dateTextField:FUITextField, priceTextView:FUITextField) {
        super.init(frame: frame)
        
        self.nameTextField = nameTextField
        self.nameTextField?.frame = CGRect(x:frame.minX, y:frame.minY, width:frame.size.width/4, height:frame.size.height)
        self.nameTextField?.textFieldColor = UIColor.white
        self.nameTextField?.text = name
        
        self.dateTextField = dateTextField
        self.dateTextField?.frame = CGRect(x:(self.nameTextField?.frame.maxX)! + 10, y:frame.minY, width:frame.size.width/4, height:frame.size.height)
        self.dateTextField?.textFieldColor = UIColor.white
        self.dateTextField?.text = ""//needed to implement convertet
        
        self.priceTextView = priceTextView
        self.priceTextView?.frame = CGRect(x:(self.dateTextField?.frame.maxX)! + 10, y:frame.minY, width:frame.size.width/4, height:frame.size.height)
        self.priceTextView?.textFieldColor = UIColor.white
        self.priceTextView?.text = String(price)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
