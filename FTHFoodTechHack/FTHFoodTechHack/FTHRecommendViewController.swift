import UIKit

import WebKit

class FTHRecommendViewController: UIViewController, WKNavigationDelegate {
    var _webkitview:WKWebView?
    
    var fthRefrigeratorModel = FTHRefrigeratorModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //why it doesnt show up when i directly move from VC.

        let bestBeforeDate:FTHFoodModel = self.fthRefrigeratorModel.expiringFoodStocks[0]
        var bestBeforeDateLabel = UILabel(frame: CGRect(x: 10, y: 50, width: self.view.bounds.size.width , height: 50))
        bestBeforeDateLabel.textAlignment = NSTextAlignment.center
        let labeltext =  ["賞味期限間近の食品：", bestBeforeDate.name]
        bestBeforeDateLabel.text = labeltext.joined(separator: " ")
        self.view.addSubview(bestBeforeDateLabel)
        self.view.backgroundColor = UIColor.white
        
        //using WKWebview to show the recomendation recipies though Rakuten recipi. 
        _webkitview?.navigationDelegate = self
        
        self._webkitview = WKWebView(frame:CGRect(x:10, y:120, width:self.view.bounds.size.width - 10, height: self.view.bounds.size.height))
        //this is a hack.need to be fixed, letting FTH searchiing w multiple materials.

        let urlstring = "http://recipe.rakuten.co.jp/search/ほうれん草"
        let url = NSURL(string:urlstring.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)
        let req = NSURLRequest(url:url as! URL)
        self._webkitview!.load(req as URLRequest)
        self.view.addSubview(_webkitview!)

      print("Best BEfore Food is %s", bestBeforeDate.name)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
