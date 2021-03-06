import UIKit
import SwiftyJSON
import Alamofire
import FlatUIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
		super.viewDidLoad()
		self.createUserAccountIfNeeded()
		
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Fresh Fridge"
        
        let seeButton = UIButton(frame: CGRect(x: 50, y: 100, width: self.view.bounds.size.width - 100, height: self.view.bounds.size.height/5))
        seeButton.backgroundColor = UIColor.red
        seeButton.setBackgroundImage(#imageLiteral(resourceName: "seecontent"), for: UIControlState.normal)
        seeButton.addTarget(self, action: #selector(didTapSeeButton), for: .touchUpInside)
        self.view.addSubview(seeButton)
        
        let addButton = UIButton(frame: CGRect(x: 50, y: 100 + seeButton.frame.height + 30, width: self.view.bounds.size.width - 100, height: self.view.bounds.size.height/5))
        addButton.backgroundColor = UIColor.red
        addButton.setBackgroundImage(#imageLiteral(resourceName: "addcontent"), for: UIControlState.normal)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        self.view.addSubview(addButton)
        
        let recButton = UIButton(frame: CGRect(x: 50, y: addButton.frame.maxY + 30, width: self.view.bounds.size.width - 100, height: self.view.bounds.size.height/5))
        recButton.backgroundColor = UIColor.red
        recButton.setBackgroundImage(#imageLiteral(resourceName: "seerecomendation"), for: UIControlState.normal)
        recButton.addTarget(self, action: #selector(didTapRecommendButton), for: .touchUpInside)
        self.view.addSubview(recButton)
        
        let addDeviceQRButton = FUIButton(frame:CGRect(x:50, y:recButton.frame.maxY + 30, width: 100, height: 60))
        addDeviceQRButton.shadowColor = UIColor.red
        addDeviceQRButton.buttonColor = UIColor(red: (252/255.0), green: (114/255.0), blue: (84/255.0), alpha: 1.0)
        addDeviceQRButton.titleLabel?.text = "AddDevice"
        addDeviceQRButton.titleLabel?.tintColor = UIColor.black
        addDeviceQRButton.addTarget(self, action: #selector(didTapQrButton), for: .touchUpInside)
        self.view.addSubview(addDeviceQRButton)
    }
    
    func didTapSeeButton(_ sender:UIButton!){
        let seeViewController = FTHSeeUIViewController()
        self.navigationController?.pushViewController(seeViewController, animated: true)
    }
    
    func didTapAddButton(_ sender: UIButton) {
        let addViewController = FTHAddViewController()
        self.navigationController?.pushViewController(addViewController, animated: true)
    }
    
    func didTapQrButton(_ sender: UIButton){
        let addQRViewController = FTHRegisterDeviceViewController()
        self.navigationController?.pushViewController(addQRViewController, animated: true)

    }
    
    func didTapRecommendButton(_ sender: UIButton) {
        let recViewController = FTHRecommendViewController()
        self.navigationController?.pushViewController(recViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func createUserAccountIfNeeded() {		
		let ud = UserDefaults.standard

		if (ud.string(forKey: "x-access-token") != nil) { return }
	
		Alamofire.request("https://app.uthackers-app.tk/user/add", method: .post, parameters: [:], encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			
			ud.set(json["user"]["access_token"].string!, forKey: "x-access-token")
			ud.set(json["family"]["token"].string!, forKey: "family-token")
		}
	}
	
	func showFamilyTokenDialog() {
		let ud = UserDefaults.standard
		let familyToken = ud.object(forKey: "family-token") as! String
		
		let alert = UIAlertController(title: "消費期限をお知らせして欲しいグループにLINE bot(@sok3197j)を招待して、下記の文字列をコピーして投稿して下さい。", message: "familytoken:\(familyToken)", preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			self.dismiss(animated: true, completion: nil)
		}))

		self.present(alert, animated: true, completion: nil)
	}
}

