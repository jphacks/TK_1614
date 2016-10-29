import Foundation
import Alamofire
import SwiftyJSON

class BestBeforeDate {
	let OCR_API_KEY = "AIzaSyAlELP4Ai9mzXNTPTuAXOIePoS09gxft-Y"
	let MA_API_KEY = "a1493145bf328317de821d99f613bd60e076d72f91cd3750551fe4a61c7993a1"

	var callback : ([ String : (NSDate, Int, Int) ]) -> Void // [ name : (id, best_before_data, price) ] -> Void
	
	init(callback : @escaping ([ String : (Int, NSDate, Int) ]) -> Void) {
		self.callback = callback
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
	
	func MARequest(_ original_text: String) {
		Alamofire.request("https://labs.goo.ne.jp/api/morph", method: .post, parameters: [
			"app_id": MA_API_KEY,
			"sentence": original_text,
			"pos_filter": "名詞"
		], encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			let nouns = json["word_list"].arrayValue.map { $0.arrayValue.map { $0[0].string } }.flatMap { $0 }
				
			self.ServerSideRequest(nouns as! [String], original_text: original_text)
		}
	}
	
	func ServerSideRequest(_ nouns: [ String ], original_text : String) {
		Alamofire.request("https://app.uthackers-app.tk/item/candidate", method: .post, parameters: [
			"query": [ "name": nouns ]
		], encoding: JSONEncoding.default).responseJSON { response in
			guard let object = response.result.value else { return }
			let json = JSON(object)
			var table : [ String : (NSDate, Int) ] = [ : ]
			
			json["item_master"].arrayValue.forEach {
				let id = $0["item_id"].to_i
				let date = calcDeadlineFromRangeString($0["default_expire_days"])
				let price = extractPriceFromFullText(original_text, word: $0["original_name"])
				
				table[name] = (id, date, price)
			}
			
			self.callback(table)
		}
	}
	
	func extractPriceFromFullText(_ text: String, word: String) -> Int {
		text.components(separatedBy: "\n").forEach {
			if text.rangeOfString(word) != nil {
				return extractPriceFrom(text, word: word)
			}
		}
		
		return 0
	}
	
	func extractPriceFromLine(_ text: String, word: String) -> Int {
		text = text.replacingOccurrences(of: ",", with: "")
		
		do {
			let pattern = "([0-9]+)$"
			let regex = try NSRegularExpression(pattern: pattern, options: [])
			let results = regex.matches(in: text, options: [], range: NSMakeRange(0, text.characters.count))
			
			return Int((text as NSString).substring(with: results[0].range))
		} catch let error as NSError {
			return 0
		}
		
		return 0
	}
	
	func extractHeadNumber(_ d : String) {
		let pattern = "^([0-9]+)"
		let regex = try NSRegularExpression(pattern: pattern, options: [])
		let results = regex.matches(in: d, options: [], range: NSMakeRange(0, d.characters.count))
		return Int((text as NSString).substring(with: results[0].range))
	}
	
	func removeSuffixOnceRipe(_ d : String) {
		let pattern = "once ripe"
		let regex = try NSRegularExpression(pattern: pattern, options: [])
		let results = regex.matches(in: d, options: [], range: NSMakeRange(0, d.characters.count))
		return Int((text as NSString).substring(with: results[0].range))
	}
	
	func calcDeadlineFromRangeString(_ date: String) -> NSDate {
		return NSDate(timeInterval: Int(date) * 60 * 60 * 24, sinceDate: NSDate())
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
		
		if (imagedata.count > 2097152) {
			let oldSize: CGSize = image.size
			let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
			
			imagedata = resizeImage(newSize, image: image)
		}
		
		return imagedata.base64EncodedString(options: .endLineWithCarriageReturn)
	}
}
