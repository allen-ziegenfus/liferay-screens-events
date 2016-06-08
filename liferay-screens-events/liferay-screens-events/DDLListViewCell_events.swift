//
//  DDLListViewCell_events.swift
//  liferay-screens-events
//
//  Created by Allen Ziegenfus on 07/06/16.
//  Copyright © 2016 Allen Ziegenfus. All rights reserved.
//

import UIKit
import LiferayScreens



public class DDLListViewCell_events: UITableViewCell {
    
   
    @IBOutlet weak var imgBackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var imgBackBottomConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var title: UILabel!
 

    
    let imageParallaxFactor: CGFloat = 20
    
    var imgBackTopInitial: CGFloat!
    var imgBackBottomInitial: CGFloat!
    
    private let dateFormatter = NSDateFormatter()
    
    public var record: DDLRecord? {
        didSet {
            if let titleField = record?.fieldBy(name: "title") {
                title.text = titleField.currentValueAsString
            }
            
            if let locationField = record?.fieldBy(name: "location_label") {
                location.text = locationField.currentValueAsString
            }
            setMyImage(record)
        }
    }
    
    func setMyImage(record: DDLRecord?) {
        if let field = record?["logo"] {
            
            if let currentValue = field.currentValueAsLabel {
                
                if currentValue != "" {
                    
                    guard let data = currentValue.dataUsingEncoding(NSUTF8StringEncoding) else {
                        return
                    }
                    
                    guard let serialized = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                        return
                        
                    }
                    //currentValue	String	"{\"groupId\":\"20182\",\"uuid\":\"504f6a21-de72-46a7-bcbf-e9038e2b9482\",\"version\":\"1.0\"}"
                    
                    guard let jsonObject = serialized as? JSONObject else {
                        return
                    }
                    //object.groupId
                    
                    //object.version
                    
                    let group = (jsonObject["groupId"] as AnyObject? as? String) ?? ""
                    let uuid = (jsonObject["uuid"] as AnyObject? as? String) ?? ""
                    let version = (jsonObject["version"] as AnyObject? as? String) ?? ""
                    
                    let url = "https://mdata.liferay.com/documents/" + group + "/" + uuid
                    //let imageName = "lpsf-2015-default.jpg"
                    let nsurl = NSURL(string: url)
                    let imagedata = NSData(contentsOfURL: nsurl!)
                    let image = UIImage(data:imagedata!)
                    imgBack.image = image
                    
                    
                }
                
            }

        }
    }
    
    override public func awakeFromNib() {
        self.clipsToBounds = true
        self.imgBackBottomConstraint.constant -= 2 * imageParallaxFactor
        self.imgBackTopInitial = self.imgBackTopConstraint.constant
        self.imgBackBottomInitial = self.imgBackBottomConstraint.constant
    }
    

    
    func setBackgroundOffset(offset:CGFloat) {
        var boundOffset = max(0, min(1, offset))
        var pixelOffset = (1-boundOffset)*2*imageParallaxFactor
        self.imgBackTopConstraint.constant = self.imgBackTopInitial - pixelOffset
        self.imgBackBottomConstraint.constant = self.imgBackBottomInitial + pixelOffset
    }

}