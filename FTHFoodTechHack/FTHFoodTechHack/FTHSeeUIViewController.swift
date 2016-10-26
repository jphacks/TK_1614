import UIKit

import RealmSwift

class FTHSeeUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fthRefrigeratorModel = FTHRefrigeratorModel()
    var backBtn: UIBarButtonItem!
    let mySections: NSArray = ["賞味期限間近の食品", "冷蔵庫内の食品"]
    fileprivate var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "冷蔵庫の中身を見る"
        backBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(FTHSeeUIViewController.onClick))
        self.navigationItem.leftBarButtonItem = backBtn
        
        myTableView = UITableView(frame:CGRect(x:30, y: 100, width:self.view.bounds.width - 60, height:self.view.bounds.height - 100))
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FoodCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        self.view.addSubview(myTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //set secton nums
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    //set sectiontitle
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fthRefrigeratorModel.expiringFoodStocks.count
        } else if section == 1 {
            return fthRefrigeratorModel.normalFoodStocks.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        if (indexPath as NSIndexPath).section == 0 {
            cell.textLabel?.text = fthRefrigeratorModel.expiringFoodStocks[(indexPath as NSIndexPath).row].name + " Expiration date : "+String(fthRefrigeratorModel.expiringFoodStocks[(indexPath as NSIndexPath).row].exdate)
        } else if (indexPath as NSIndexPath).section == 1 {
            cell.textLabel?.text = fthRefrigeratorModel.normalFoodStocks[(indexPath as NSIndexPath).row].name + " Expiration date : "+String(fthRefrigeratorModel.normalFoodStocks[(indexPath as NSIndexPath).row].exdate)
        }
        return cell
    }
    
    func onClick() {
        let home = ViewController()
        self.navigationController?.pushViewController(home, animated: true)
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
