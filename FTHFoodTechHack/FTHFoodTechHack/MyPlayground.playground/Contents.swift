//: Playground - noun: a place where people can play

import UIKit

var text = "キャベツ  ¥2,000"
var word = "キャベツ"

text = text.replacingOccurrences(of: ",", with: "")

let pattern = "([0-9]+)$"
let regex = try NSRegularExpression(pattern: pattern, options: [])
let results = regex.matches(in: text, options: [], range: NSMakeRange(0, text.characters.count))

print((text as NSString).substring(with: results[0].range))
