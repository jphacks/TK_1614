import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import AVFoundation

class FTHRegisterDeviceViewController : ViewController, AVCaptureMetadataOutputObjectsDelegate {
	override func viewDidLoad() {
		let mySession: AVCaptureSession! = AVCaptureSession()
		let devices = AVCaptureDevice.devices()
		var myDevice: AVCaptureDevice!

		for device in devices! {
			if((device as AnyObject).position == AVCaptureDevicePosition.back){
				myDevice = device as! AVCaptureDevice
			}
		}
		
		let myVideoInput = try! AVCaptureDeviceInput.init(device: myDevice)

		if mySession.canAddInput(myVideoInput) {
			mySession.addInput(myVideoInput)
		}
		
		let myMetadataOutput: AVCaptureMetadataOutput! = AVCaptureMetadataOutput()
		
		if mySession.canAddOutput(myMetadataOutput) {
			mySession.addOutput(myMetadataOutput)
			myMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
			myMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
		}
		
		let myVideoLayer = AVCaptureVideoPreviewLayer.init(session: mySession)
		myVideoLayer?.frame = self.view.bounds
		myVideoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill

		self.view.layer.addSublayer(myVideoLayer!)
		
		mySession.startRunning()
	}
	
	private func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, from connection: AVCaptureConnection!) {
		if metadataObjects.count > 0 {
			let qrData: AVMetadataMachineReadableCodeObject  = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
			print("\(qrData.type)")
			print("\(qrData.stringValue)")
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
