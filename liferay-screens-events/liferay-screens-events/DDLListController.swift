//
//  DDLListController.swift
//  liferay-screens-events
//
//  Created by Allen Ziegenfus on 08/06/16.
//  Copyright © 2016 Allen Ziegenfus. All rights reserved.
//

import Foundation
import UIKit
import LiferayScreens

class DDLListController: UIViewController, DDLListScreenletDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.ddllist.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var ddllist: DDLListScreenlet!
}

