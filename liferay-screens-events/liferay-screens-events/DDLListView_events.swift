//
//  DDLListView_events.swift
//  liferay-screens-events
//
//  Created by Allen Ziegenfus on 07/06/16.
//  Copyright © 2016 Allen Ziegenfus. All rights reserved.
//

import Foundation
import UIKit
import LiferayScreens

public typealias JSONObject = [String:AnyObject]

public class DDLListView_events: BaseListTableView, DDLListViewModel {
    
    
    public var labelFields: [String] = []
    
    
    override public func doFillLoadedCell(row row: Int, cell: UITableViewCell, object:AnyObject) {
        
        if let record = object as? DDLRecord {
            
            cell.textLabel?.text = "Event: " + composeLabel(record)
            cell.detailTextLabel?.text = "Test Detail Label"
            
           
            ///documents/67510365/8c4a085d-5548-45f8-bb8c-5aae4cecab4c?
            
            //let imageName = "lpsf-2015-default.jpg"
            //let image = UIImage(named: imageName)
            //cell.imageView!.image = image
            
            
            if let field = record["logo"] {
                
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

                        
                        cell.imageView!.image = image
                       
                        
                    }
                    
                }
                
            }

     
            
            
            cell.accessoryType = .DisclosureIndicator
            
            cell.accessoryView = nil
            
        }
        
    }
    
    
    override public func doFillInProgressCell(row row: Int, cell: UITableViewCell) {
        
        cell.textLabel?.text = "..."
        
        cell.accessoryType = .None
        
        
        
        if let image = NSBundle.imageInBundles(
            
            name: "default-hourglass",
            
            currentClass: self.dynamicType) {
            
            cell.accessoryView = UIImageView(image: image)
            
            cell.accessoryView!.frame = CGRectMake(0, 0, image.size.width, image.size.height)
            
        }
        
    }
    
  
    
    public func composeLabel(record: DDLRecord) -> String {
        
        var result: String = ""
        
        
        
        for labelField in labelFields {
            
            if let field = record[labelField] {
                
                if let currentValue = field.currentValueAsLabel {
                    
                    if currentValue != "" {
                        
                        result += currentValue
                        
                        result += " "
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
        if result.endIndex == result.startIndex {
            
            print("[ERROR] Can't compose the label for record. It seems the fields specified are not valid\n")
            
        }
            
        else {
            
            result.removeAtIndex(result.endIndex.predecessor())
            
        }
        
        
        
        return result
        
    }
    
    
    
    
    
    //MARK: DDLFormTableView
    
    
    
    override public func createProgressPresenter() -> ProgressPresenter {
        
        return DefaultProgressPresenter()
        
    }
}
