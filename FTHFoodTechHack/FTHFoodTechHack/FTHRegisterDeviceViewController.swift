import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import AVFoundation

class FTHRegisterDeviceViewController : ViewController, AVCaptureMetadataOutputObjectsDelegate {
	override func viewDidLoad() {

	}
	
	func readQR(_ image : UIImage) {
		let ciimg = CIImage(image: image)!
		let detector = CIDetector(ofType: CIDetectorTypeQRCode,  context: nil, options: nil)
		let results = detector?.features(in: ciimg) as! [CIQRCodeFeature]

		if results.isEmpty {
			// Failed to detect
		} else {
			print(results[0].messageString)
			registerDevice(results[0].messageString!)
		}
	}
	
	func registerDevice(_ token : String) {
		Alamofire.request("https://app.uthackers-app.tk/item/candidate", method: .post, parameters: [
			"family" : [ "token" : token ]
		], encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			print("Register Device Status Code: \(json["meta"]["status"].string!)")
		}
	}
}
