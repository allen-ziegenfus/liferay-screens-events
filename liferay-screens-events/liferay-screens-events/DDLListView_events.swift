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
    
    
    override public func doRegisterCellNib(id id: String) {
        let nib = UINib(
            nibName: "DDLListViewCell_events",
            bundle: NSBundle(forClass: self.dynamicType))
        
        self.tableView!.registerNib(nib, forCellReuseIdentifier: id)
    }
    
    override public func doFillLoadedCell(row row: Int, cell: UITableViewCell, object:AnyObject) {
        if let record = object as? DDLRecord,
            issueCell = cell as? DDLListViewCell_events {
            
            issueCell.record = record
            
        }
    }
    


    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        for indexPath in self.tableView!.indexPathsForVisibleRows! as [NSIndexPath] {
            self.setCellImageOffset(self.tableView!.cellForRowAtIndexPath(indexPath) as! DDLListViewCell_events, indexPath: indexPath)
        }
    }
    func setCellImageOffset(cell: DDLListViewCell_events, indexPath: NSIndexPath) {
        var cellFrame = self.tableView!.rectForRowAtIndexPath(indexPath)
        var cellFrameInTable = self.tableView!.convertRect(cellFrame, toView:self.tableView!.superview)
        var cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        var tableHeight = self.tableView!.bounds.size.height + cellFrameInTable.size.height
        var cellOffsetFactor = cellOffset / tableHeight
        cell.setBackgroundOffset(cellOffsetFactor)
    }
    

    
    
    
    //MARK: DDLFormTableView
    
    
    
    override public func createProgressPresenter() -> ProgressPresenter {
        
        return DefaultProgressPresenter()
        
    }
}
