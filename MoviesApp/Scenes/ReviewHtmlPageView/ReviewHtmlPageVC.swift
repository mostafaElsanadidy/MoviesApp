//
//  ReviewHtmlPageVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit
import WebKit

class ReviewHtmlPageVC: UIViewController {

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var webView: WKWebView!
    
    var contentUrlStr:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.titleLabel.isHidden = false
        navBarView.titleLabel.text = "Youtube"
        
        guard let url = URL(string: contentUrlStr) else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsLinkPreview = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
