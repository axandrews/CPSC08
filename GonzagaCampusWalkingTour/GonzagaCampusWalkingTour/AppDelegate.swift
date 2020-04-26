//
//  AppDelegate.swift
//  GonzagaCampusWalkingTour
//
//  Created by Max Heinzelman on 10/23/19.
//  Copyright © 2019 Senior Design Group 8. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

/*Icons made by <a href="https://www.flaticon.com/authors/those-icons" title="Those Icons">Those Icons</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
 Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var keys: NSDictionary?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(getValue(key: "GOOGLE_MAPS_API_KEY"))
        FirebaseApp.configure()
        injectDatabaseDependancy()
        return true
    }
    
    func injectDatabaseDependancy() {
        if let vc = window?.rootViewController as? UINavigationController {
            let db: DatabaseAccessible = FirebaseDataAccess()
            //vc.databaseReference = db
            if let topVC = vc.topViewController as? ViewController {
                topVC.databaseReference = db
            }
        }
        else {
            //should change this
            fatalError("cannot initialize database")
        }
    }
    
    func getValue(key: String) -> String {
        if keys == nil {
            if let path = Bundle.main.path(forResource: "config", ofType: "plist") {
                keys = NSDictionary(contentsOfFile: path)
            }
        }
        if keys != nil {
            if let val = keys?[key] as? String {
                return val
            }
        }
        return ""
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

