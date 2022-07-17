//
//  Reload.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import UIKit

protocol ReloadDelegate {
    func goToHomeVC(window:UIWindow)
}

extension ReloadDelegate {
    
    func goToHomeVC(window:UIWindow) {

        let transition: UIView.AnimationOptions = .transitionFlipFromLeft
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let nav1 = UINavigationController()
        nav1.navigationBar.tintColor = #colorLiteral(red: 0.7997059226, green: 0.6618819237, blue: 0.3807252049, alpha: 1)

        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainDiscoveryVC = storyboard.instantiateViewController(withIdentifier :"MainDiscoveryVC") as! MainDiscoveryVC
//
      //  let navController = UINavigationController.init(rootViewController: MainDiscoveryVC.instantiate())
        
        let navController = UINavigationController()
        let coordinator = MainCoordinator.init(navigationController: navController)
        
        //ad.isLoggedIn() ? homeVC  : loginVC )

//        let newRoot  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootTabBar")
        
        
        if #available(iOS 13.0, *) {
            if let delegate = UIApplication.shared.connectedScenes.first?.delegate {
                if let window = (delegate as? SceneDelegate)?.window {
                    window.rootViewController =  navController
                    window.makeKeyAndVisible()
                }
            }
            else {
                rootviewcontroller.rootViewController =  navController
                rootviewcontroller.makeKeyAndVisible()
            }
        } else {
            // Fallback on earlier versions
        }
        coordinator.start()

        let mainwindow = (UIApplication.shared.delegate?.window!)!
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
            
        }
    }

//    func goToHomeVC(window:UIWindow) {
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        //LOGIN
//        let loginVC = storyboard.instantiateViewController(withIdentifier :"LoginVC") as! LoginVC
//        //HOME
//        let homeVC = storyboard.instantiateViewController(withIdentifier :"HomeVC") as! HomeVC
//
//
//        let navController = UINavigationController.init(rootViewController: ad.isLoggedIn() ? homeVC  : loginVC )
//
//
//        //        let navController = UINavigationController.init(rootViewController: loginVC)
//
//        //        navController.isNavigationBarHidden = true
//        //        let yourBackImage = UIImage(named: "return-arrow")
//        //        navController.navigationBar.backIndicatorImage = yourBackImage
//        //        navController.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//        navController.navigationBar.topItem?.title = ""
//
//
//        window.rootViewController = navController
//        window.makeKeyAndVisible()
//
//    }
}
