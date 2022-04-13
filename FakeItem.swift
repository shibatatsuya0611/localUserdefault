//
//  File.swift
//  PhoToMaker
//
//  Created by Admin on 3/18/22.
//

import Foundation
import UIKit
struct fakeTemplate{
    var type: String
    var view: UIView
    var frame: CGRect
    var transform: CGAffineTransform
    var filter: String?
    var shadownValue: CGFloat
    var gocDoBong: String
    var textColor: UIColor?
    var textBGColor: UIColor?
    var font: UIFont?
    var text: String?
    
}
var itemArr = [
    fakeTemplate(type: "image", view: UIImageView.init(image: #imageLiteral(resourceName: "PhotoRoom_20220307_111935")), frame: CGRect(x: 166.837, y: 55.8374, width: 99.3252, height: 99.3252), transform: CGAffineTransform(a: 0.99580967500241013, b: -0.091449938062277358, c: -0.091449938062277358, d: 0.99580967500241013, tx: 0, ty: 0), filter: "CIPhotoEffectFade", shadownValue: 5, gocDoBong: "top"),
    fakeTemplate(type: "text", view: UITextView(), frame: CGRect(x: 166.837, y: 55.8374, width: 99.3252, height: 99.3252), transform: CGAffineTransform(a: 0.99580967500241013, b: -0.091449938062277358, c: -0.091449938062277358, d: 0.99580967500241013, tx: 0, ty: 0), filter: nil, shadownValue: 8, gocDoBong: "left", textColor: .red, textBGColor: .clear, font: UIFont(name: "Roboto-Bold", size: 15), text: "template")
]
//public struct PoohWisdomProducts {
public let monthlySub = "paymentForMonth"
public let yearlySub = "paymentForYear"
///
class LocalData: NSObject, NSCoding {
    var id: Int
    var templ: [ItemContainerView]


    init(id: Int, templ: [ItemContainerView]) {
        self.id = id
        self.templ = templ

    }

    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let templ = aDecoder.decodeObject(forKey: "templ") as! [ItemContainerView]
        self.init(id: id, templ: templ)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(templ, forKey: "templ")
    }
}
var local: [LocalData] = [LocalData]()
func loadPeople() -> [LocalData]? {

        if let unarchivedObject = INIT_USER_DEFAULTS.object(forKey: "currentProject") as? Data {

            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [LocalData]
        }

        return nil
    
}
func loadAllSearchTags() -> [LocalData] {
        var arrs = [LocalData]()
        guard let savedItems = UserDefaults.standard.array(forKey: "currentProject") else { return [] }
        for savedItem in savedItems {
            guard let collect = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? LocalData else { continue }
            arrs.append(collect)
        }
        return arrs
}
