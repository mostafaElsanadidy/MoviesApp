//
//  ReviewHtmlPageVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit
import WebKit

class ReviewHtmlPageVC: UIViewController,Storyboarded {

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var webView: WKWebView!
    
   private var viewModel = ReviewHtmlPageViewModel()
    
    weak var coordinator : ReviewHtmlPageCoordinator?

    func initialState(viewModel:ReviewHtmlPageViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupBinder()
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.titleLabel.isHidden = false
        navBarView.titleLabel.text = "Youtube"
        
        
    }
    
    func setupBinder() {
        
        self.viewModel.contentUrlStr.bind{
            [weak self] contentUrlStr in
            guard let strongSelf = self,
                  let contentUrlStr = contentUrlStr else {return}
            DispatchQueue.main.async{
                guard let url = URL(string: contentUrlStr) else {
                    return
                }
                strongSelf.webView.load(URLRequest(url: url))
                strongSelf.webView.allowsLinkPreview = true
            }
        }
        
    }
}
