import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import AVFoundation

class FTHRegisterDeviceViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
    var qrImageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImageView()
        self.pickImageFromCamera()
        
	}
	
	func readQR(_ image : UIImage) {
		let ciimg = CIImage(image: image)!
		let detector = CIDetector(ofType: CIDetectorTypeQRCode,  context: nil, options: nil)
		let results = detector?.features(in: ciimg) as! [CIQRCodeFeature]

		if results.isEmpty {
			// Failed to detect
		} else {
			registerDevice(results[0].messageString!)
		}
        let viewController = ViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	func registerDevice(_ token : String) {
		Alamofire.request("https://app.uthackers-app.tk/user/connect", method: .post, parameters: [
			"family" : [ "token" : token ]
		], encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			print("Register Device Status Code: \(json["meta"]["status"].string!)")
		}
	}
    
    func setupImageView()
    {
        qrImageView = UIImageView()
        
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 200
        let buttonWidth:CGFloat = 200
        let buttonHeight:CGFloat = 200
        
        qrImageView.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        
        self.view.addSubview(qrImageView)
    }
    
    func pickImageFromCamera() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            qrImageView.image = pickedImage
            qrImageView.isHidden  = true
            self.readQR(qrImageView.image!)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        if error != nil {
            //プライバシー設定不許可など書き込み失敗時は -3310 (ALAssetsLibraryDataUnavailableError)
            print(error.code)
        }
    }
    
}
