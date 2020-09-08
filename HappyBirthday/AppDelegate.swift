//
//  AppDelegate.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let detailsViewModel = DetailsViewModel()
        window.rootViewController = DetailsViewController(viewModel: detailsViewModel)
        window.makeKeyAndVisible()
        self.window = window
        return true
        
    }

}

