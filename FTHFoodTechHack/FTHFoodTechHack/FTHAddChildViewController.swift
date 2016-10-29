import UIKit
import RealmSwift
import FlatUIKit
import SSBouncyButton

class FTHAddChildViewController: UIViewController, UITextFieldDelegate, FUIAlertViewDelegate{

    let foodTextField = UITextField()
    let numTextField = UITextField()
    let dateTextField = UITextField()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        let foodLabel = UILabel(frame:CGRect(x: 30, y: 100, width: 80 , height: 50))
         foodLabel.textAlignment = NSTextAlignment.center

         foodLabel.text = "食材名"
        self.view.addSubview(foodLabel)
        
        foodTextField.frame = CGRectMake(foodLabel.frame.maxX, 100, 200 , 50)
        foodTextField.delegate = self
        foodTextField.borderStyle = UITextBorderStyle.roundedRect
        foodTextField.layer.borderColor = UIColor.gray.cgColor
        foodTextField.layer.borderWidth = 1.0
        self.view.addSubview(foodTextField)
        
        let numLabel = UILabel(frame: CGRect(x: 30, y: foodLabel.frame.maxY + 10, width: 80 , height: 50))
        numLabel.textAlignment = NSTextAlignment.center
        numLabel.text = "個数"
        self.view.addSubview(numLabel)
        
        numTextField.frame = CGRectMake(foodLabel.frame.maxX,foodLabel.frame.maxY + 10, 200 , 50)
        numTextField.delegate = self
        numTextField.borderStyle = UITextBorderStyle.roundedRect
        numTextField.layer.borderColor = UIColor.gray.cgColor
        numTextField.layer.borderWidth = 1.0
        self.view.addSubview(numTextField)
        
        let dateLabel = UILabel(frame: CGRect(x: 30, y: numLabel.frame.maxY + 10, width: 80 , height: 50))
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.text = "賞味期限"
        self.view.addSubview(dateLabel)
        
        dateTextField.frame = CGRectMake(foodLabel.frame.maxX, numLabel.frame.maxY + 10, 200 , 50)
        dateTextField.delegate = self
        dateTextField.borderStyle = UITextBorderStyle.roundedRect
        dateTextField.layer.borderColor = UIColor.gray.cgColor
        dateTextField.layer.borderWidth = 1.0
        self.view.addSubview(dateTextField)
        
        let trybutton = SSBouncyButton()
        trybutton.frame = CGRectMake(foodLabel.frame.maxX, dateTextField.frame.maxY + 10, 100, 50)
        trybutton.backgroundColor =  UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        trybutton.titleLabel?.textColor = UIColor.black
        
        trybutton.setTitle("追加する", for: UIControlState())
        trybutton.addTarget(self, action: #selector(didTapAddButton), for:.touchUpInside)
        self.view.addSubview(trybutton)       
    }

    override func didReceiveMemoryWarning() {}
    
    func didTapAddButton(sender: UIButton){
        let realm = try! Realm()
        let realmFoodStock = RealmFoodStock()
        realmFoodStock.name = foodTextField.text!
        realmFoodStock.exdate = Int(dateTextField.text!)!
        realmFoodStock.num = Int(numTextField.text!)!
        
        try! realm.write{
            realm.add(realmFoodStock)
        }
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
