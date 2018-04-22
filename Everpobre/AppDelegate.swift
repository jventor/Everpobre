//
//  AppDelegate.swift
//  Everpobre
//
//  Created by Jaime Ventor on 2/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let splitViewController = UISplitViewController()
  var notebookListVC : NotebookListController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    
//    UINavigationBar.appearance().backgroundColor = .mainColor
//    navController.navigationBar.barTintColor = .mainColor


    notebookListVC = NotebookListController()
    
    let navController = UINavigationController(rootViewController: notebookListVC!)
    //navController.navigationBar.prefersLargeTitles = true
    navController.navigationBar.topItem?.title = "Everpobre"
    
    // Controller vacio, al abrir no hay notas seleccionadas
    let emptyVC = UIViewController().wrappedInNavigation()
    emptyVC.view.backgroundColor = UIColor.lightGray
    
    splitViewController.viewControllers = [navController, emptyVC]
    splitViewController.delegate = self
    window?.rootViewController = splitViewController
    
//    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//    print(documentDirectory.absoluteString)
    
    return true
  }

}

extension AppDelegate : UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}
