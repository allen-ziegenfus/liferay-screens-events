//
//  ViewController.swift
//  liferay-screens-events
//
//  Created by Allen Ziegenfus on 06/06/16.
//  Copyright © 2016 Allen Ziegenfus. All rights reserved.
//

import UIKit
import LiferayScreens

class ViewController: UIViewController, LoginScreenletDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.login.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func screenlet(screenlet: BaseScreenlet,
                    onLoginResponseUserAttributes attributes: [String:AnyObject]) {
        print("login done \(attributes)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("ddlView") as UIViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
        
    }
    
     func screenlet(screenlet: BaseScreenlet,
                    onLoginError error: NSError) {
        print("login error \(error)")
        
    }

    @IBOutlet weak var login: LoginScreenlet!
}

