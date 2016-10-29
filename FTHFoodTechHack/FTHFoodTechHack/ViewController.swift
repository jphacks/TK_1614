import UIKit
import SwiftyJSON
import Alamofire

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
    }
    
    func didTapSeeButton(_ sender:UIButton!){
        let seeViewController = FTHSeeUIViewController()
        self.navigationController?.pushViewController(seeViewController, animated: true)
    }
    
    func didTapAddButton(_ sender: UIButton) {
        let addViewController = FTHAddViewController()
        self.navigationController?.pushViewController(addViewController, animated: true)
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
		return // user/addが機能してないので
		
		let ud = UserDefaults.standard

		if (ud.object(forKey: "x-access-token") != nil) { return }

		Alamofire.request("https://labs.goo.ne.jp/user/add", method: .post, encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			
			ud.set("x-access-token", forKey: json["user"]["access_token"].string!)
			ud.set("user-id", forKey: json["user"]["user_id"].string!)
		}
	}
}

