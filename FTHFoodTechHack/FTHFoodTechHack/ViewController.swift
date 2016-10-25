import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
//        self.navigationController?.navigationBar
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        self.navigationItem
//        self.navigationItem.title = "Fresh Fridge"
        
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
        let seeView = self.storyboard!.instantiateViewController(withIdentifier: "see")
        self.present(seeView, animated:true, completion:nil)
    }
    
    func didTapAddButton(_ sender: UIButton) {
        let addView = self.storyboard!.instantiateViewController(withIdentifier: "add")
        self.present(addView, animated: true, completion: nil)
    }
    
    func didTapRecommendButton(_ sender: UIButton) {
        let recView = self.storyboard!.instantiateViewController(withIdentifier: "rec")
        self.present(recView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

