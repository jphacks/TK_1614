import UIKit
import SwiftyJSON
import FlatUIKit

class FTHConfirmationViewController: UIViewController {
    var myScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView = UIScrollView()
        myScrollView.frame = CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height)
        myScrollView.contentSize = CGSize(width:self.view.frame.size.width, height:2000)
        self.view.addSubview(myScrollView)
        
//        for index in 1...5 {
//            let confirmationView = FTHConfirmationSubView(frame: , name:, date: , price: )
//            confirmationView.dateTextField.inputView = 
//            
//        }
    }
    
}

