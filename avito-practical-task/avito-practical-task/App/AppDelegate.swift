//
//  AppDelegate.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import CocoaLumberjack
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupCocoaLumberjack()
        DDLog.add(DDOSLogger.sharedInstance)
        DDLog.add(DDFileLogger())
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options _: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {}

    private func setupCocoaLumberjack() {
        #if DEBUG
            DDLog.add(DDOSLogger.sharedInstance, with: .verbose)
        #else
            DDLog.add(DDFileLogger())
        #endif
    }
}
