//
//  FTHDeviceRegistViewController.swift
//  FTHFoodTechHack
//
//  Created by KARASAWAHIROAKI on 2016/10/30.
//  Copyright © 2016年 浅井紀子. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import AVFoundation

class FTHRegisterDeviceViewController : ViewController, AVCaptureMetadataOutputObjectsDelegate {
	let session = AVCaptureSession()

	override func viewDidLoad() {
		let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
		let input = try? AVCaptureDeviceInput(device: device)
		session.addInput(input)
		
		let output = AVCaptureMetadataOutput()
		output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
		session.addOutput(output)
		output.metadataObjectTypes = output.availableMetadataObjectTypes
		
		let layer = AVCaptureVideoPreviewLayer(session: session)
		layer?.frame = view.bounds
		layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
		view.layer.addSublayer(layer!)
		
		session.startRunning()
	}
	
	private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
		
		print(metadataObjects.flatMap { $0.stringValue })
		self.registerDevice(metadataObjects.flatMap { $0.stringValue }.joined())
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
