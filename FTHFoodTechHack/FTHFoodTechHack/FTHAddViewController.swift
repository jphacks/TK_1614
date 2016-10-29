import UIKit
import RealmSwift
//image pickerdoesnt work??? 

class FTHAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var fthRefrigeratorModel = FTHRefrigeratorModel()
    var myImageView:UIImageView!
    
    override func viewDidLoad() {
		print("VIEW DID LOAD================================")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        let addLabel = UILabel(frame: CGRect(x: 10, y: 100, width: self.view.bounds.size.width , height: 50))
        addLabel.textAlignment = NSTextAlignment.center
        addLabel.text = "食材を追加する方法を選んでください。"
        self.view.addSubview(addLabel)
        
        //init a button for taing pics
        let takePicButton =  UIButton(frame: CGRect(x: 50, y: 200, width: self.view.bounds.size.width / 3, height: self.view.bounds.size.width / 3))
        takePicButton.backgroundColor = UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        takePicButton.setTitle("写真を撮る", for: UIControlState())
        takePicButton.addTarget(self, action: #selector(pickImageFromCamera), for:.touchUpInside)
        self.view.addSubview(takePicButton)
        
        //init a button for adding food by directly typing
        let typingButton =  UIButton(frame: CGRect(x: 30 + takePicButton.frame.maxX, y: 200, width: self.view.bounds.size.width / 3, height: self.view.bounds.size.width / 3))
        typingButton.backgroundColor = UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        typingButton.setTitle("入力する", for: UIControlState())
        typingButton.addTarget(self, action: #selector(didTapAddbyTypingButton), for:.touchUpInside)
        self.view.addSubview(typingButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupImageView()
    {
        myImageView = UIImageView()
        
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 200
        let buttonWidth:CGFloat = 200
        let buttonHeight:CGFloat = 200
        
        myImageView.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        
        self.view.addSubview(myImageView)
    }
    
    // 写真を撮ってそれを選択
    func pickImageFromCamera() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.backgroundColor = UIColor.clear
        myImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapAddbyTypingButton(_ sender: UIButton){
        let addChildViewController = FTHAddChildViewController()
        self.navigationController?.pushViewController(addChildViewController, animated: true)
        
    }
    
}
