//
//  AppDelegate_S.swift
//  Zawidha
//
//  Created by Maher on 10/4/20.
//

import UIKit
import NVActivityIndicatorView
import MOLH

let ad = UIApplication.shared.delegate as! AppDelegate

extension AppDelegate {
    
    func isLoading() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func killLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    // MARK: - Redirect TO VC
    @objc func redirect_TO(vc : UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        sceneDelegate.redirect_To_VC(vc: vc)
    }
    
    // MARK: - Current Root VC
    func CurrentRootVC() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return nil
        }
        return  sceneDelegate.window?.currentViewController()
    }
    
    func isLoggedIn() -> Bool {
        
        if let x = UserDefaults.standard.object(forKey: "Logged") as? String {
            if x.isEmpty {
                return false
            }else{
                return true
            }
        }
        else {
            return false
        }
    }
    
    func goToHomeVC() {
        goToHomeVC(window: ad.window!)
    }
}

extension SceneDelegate{
    
    // MARK: - Redirect To VC
    @objc func redirect_To_VC(vc : UIViewController) {
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}


// MARK: - AD Current
/** @abstract UIWindow hierarchy category.  */
public extension UIWindow {
    
    /** @return Returns the current Top Most ViewController in hierarchy.   */
    func topMostWindowController()->UIViewController? {
        
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
    /** @return Returns the topViewController in stack of topMostWindowController.    */
    func currentViewController()->UIViewController? {
        
        var currentViewController = topMostWindowController()
        
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        return currentViewController
    }
}
