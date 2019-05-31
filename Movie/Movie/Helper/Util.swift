//
//  Util.swift
//  Movie
//
//  Created by Rajendra Nayak on 5/30/19.
//  Copyright © 2019 Rajendra Solutions. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    static var screenSize: CGRect = UIScreen.main.bounds
    
    class func showHUD() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if(appDelegate.isHudShowing == false){
                appDelegate.isHudShowing = true
                //  let window :UIWindow = UIApplication.shared.keyWindow!
                let hud = MBProgressHUD.showAdded(to: appDelegate.window, animated: true)
                hud?.mode = MBProgressHUDMode.indeterminate
                hud?.labelText = "Loading..."
                hud?.dimBackground = true
            }
        }
    }
    
    class func hideHUD() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            if(appDelegate.isHudShowing == true){
                appDelegate.isHudShowing = false
                MBProgressHUD.hide(for: appDelegate.window, animated:true)
            }
        }
    }
    
}
