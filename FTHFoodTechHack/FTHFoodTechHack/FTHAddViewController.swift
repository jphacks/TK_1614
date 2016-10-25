import UIKit
import RealmSwift
//image pickerdoesnt work??? 

class FTHAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var fthRefrigeratorModel = FTHRefrigeratorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let addLabel = UILabel(frame: CGRect(x: 10, y: 100, width: self.view.bounds.size.width , height: 50))
        addLabel.textAlignment = NSTextAlignment.center
        addLabel.text = "食材を追加する方法を選んでください。"
        self.view.addSubview(addLabel)
        
        //init a button for taing pics
        let takePicButton =  UIButton(frame: CGRect(x: 50, y: 200, width: self.view.bounds.size.width / 3, height: self.view.bounds.size.width / 3))
        takePicButton.backgroundColor = UIColor.red
        takePicButton.setTitle("写真を撮る", for: UIControlState())
        self.view.addSubview(takePicButton)
        
        //init a button for adding food by directly typing
        let typingButton =  UIButton(frame: CGRect(x: 30 + takePicButton.frame.maxX, y: 200, width: self.view.bounds.size.width / 3, height: self.view.bounds.size.width / 3))
        typingButton.backgroundColor = UIColor.red
        typingButton.setTitle("入力する", for: UIControlState())
        typingButton.addTarget(self, action: #selector(didTapAddbyTypingButton), for:.touchUpInside)
        self.view.addSubview(typingButton)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 写真を撮ってそれを選択
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.camera
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func didTapAddbyTypingButton (_ sender:UIButton){
//        self.fthRefrigeratorModel.addFoodByTyping(name: "あああああああ", exdate: 0, num: 100)
//        
//    }
    
    func didTapAddbyTypingButton(_ sender: UIButton){
        let recView = self.storyboard!.instantiateViewController(withIdentifier: "addchild")
        self.present(recView, animated: true, completion: nil)
        
    }
    
}
