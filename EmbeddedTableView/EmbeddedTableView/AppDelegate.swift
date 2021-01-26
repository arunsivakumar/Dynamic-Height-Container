//
//  AppDelegate.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 10/1/21.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let wvc = WidgetsContainerViewController()
        let lvc = ListViewController()
        let vc = sb.instantiateViewController(withIdentifier: "ViewController")
        wvc.content = [lvc]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = wvc
        self.window?.makeKeyAndVisible()
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
        return true
    }
}

