//
//  BestBeforeData.swift
//  FTHFoodTechHack
//
//  Created by KARASAWAHIROAKI on 2016/10/27.
//  Copyright © 2016年 浅井紀子. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BestBeforeDate {
	let OCR_API_KEY = "AIzaSyAlELP4Ai9mzXNTPTuAXOIePoS09gxft-Y"
	let MA_API_KEY = "a1493145bf328317de821d99f613bd60e076d72f91cd3750551fe4a61c7993a1"

	var callback : ([ String : (NSDate, Int) ]) -> Void // [ name : (best before data, price) ] -> Void
	
	init(callback : @escaping ([ String : (NSDate, Int) ]) -> Void) {
		self.callback = callback
	}
	
	func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
		UIGraphicsBeginImageContext(imageSize)
		image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))

		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		let resizedImage = UIImagePNGRepresentation(newImage!)
		
		UIGraphicsEndImageContext()
		
		return resizedImage!
	}
	
	func base64EncodeImage(_ image: UIImage) -> String {
		var imagedata = UIImagePNGRepresentation(image)!
		
		// Resize the image if it exceeds the 2MB API limit
		if (imagedata.count > 2097152) {
			let oldSize: CGSize = image.size
			let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
			
			imagedata = resizeImage(newSize, image: image)
		}
		
		return imagedata.base64EncodedString(options: .endLineWithCarriageReturn)
	}
	
	func fetch(_ image : UIImage) {
		self.OCRRequest(base64EncodeImage(image))
	}
	
	func OCRRequest(_ imageData: String) {
		Alamofire.request("https://vision.googleapis.com/v1/images:annotate?key=\(OCR_API_KEY)", method: .post, parameters: [
			"requests": [
				"image": [ "content": imageData	],
				"features": [ [	"type": "TEXT_DETECTION", "maxResults": 10] ]
			]
			], encoding: JSONEncoding.default).responseJSON { response in
				guard let object = response.result.value else {	return }
				let json = JSON(object)
				guard let full_text = json["responses"][0]["textAnnotations"][0]["description"].string else { return }
				
				self.MARequest(full_text)
		}
	}
	
	func MARequest(_ text: String) {
		Alamofire.request("https://labs.goo.ne.jp/api/morph", method: .post, parameters: [
			"app_id": MA_API_KEY,
			"sentence": text,
			"pos_filter": "名詞"
		], encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			let nouns = json["word_list"].arrayValue.map { $0.arrayValue.map { $0[0].string } }.flatMap { $0 }
				
			self.ServerSideRequest(nouns as! [String])
		}
	}
	
	func ServerSideRequest(_ nouns: [ String ]) {
		var table : [ String : (NSDate, Int)] = [:] // [ name : best before date ]
		
		nouns.forEach {
			let sinceNow = (Int(arc4random_uniform(11)) + 3) * 24 * 60 * 60
			table[$0] = (NSDate(timeIntervalSinceNow: Double(sinceNow)), Int(arc4random_uniform(600)) + 100)
		}
		
		callback(table)
	}
}
