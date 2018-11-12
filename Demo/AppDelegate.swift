//
//  AppDelegate.swift
//  Demo
//
//  Created by Sean Lim on 23/10/18.
//  Copyright © 2018 Heka. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	private enum Storyboard: String {
		case onboarding = "Onboarding"
		case signup = "SignUp"
		case main = "Main"
		
		func scene() -> UIStoryboard {
			return UIStoryboard.init(name: self.rawValue , bundle: .main)
		}
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		IQKeyboardManager.shared().isEnabled = true

		self.window = UIWindow(frame: UIScreen.main.bounds)
		
		let doneOnboarding = UserDefaults.standard.bool(forKey: "doneOnboarding")
		let signedUp = UserDefaults.standard.bool(forKey: "signedUp")
		var storyboard: UIStoryboard?
		
		// Override entry point for debugging
		let overwriteEntry: UIStoryboard? = nil
		
		if overwriteEntry != nil {
			storyboard = overwriteEntry
		} else if !doneOnboarding {
			storyboard = Storyboard.onboarding.scene()
		} else if !signedUp {
			storyboard = Storyboard.signup.scene()
		} else {
			// P2P id
			P2PClientID = UUID().uuidString
			P2PManager()
			storyboard = Storyboard.main.scene()
		}
		
		let initialViewController = storyboard!.instantiateInitialViewController()
		self.window?.rootViewController = initialViewController
		self.window?.makeKeyAndVisible()
		
		return true
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

