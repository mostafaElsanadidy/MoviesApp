//
//  VideoYoutubeLinkVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit
import WebKit

class VideoYoutubeLinkVC: UIViewController,Storyboarded {

    @IBOutlet weak var navBarView: NavBarView!
    
   // @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var webView2: WKWebView!
    
    private var youtubeVideoViewModel = YoutubeVideoViewModel()
    
    weak var coordinator : YoutubeVideoCoordinator?
   func initialState(viewModel:YoutubeVideoViewModel) {
       self.youtubeVideoViewModel = viewModel
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBinder()
        
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.titleLabel.isHidden = false
        navBarView.titleLabel.text = "Youtube"
        
        webView2.allowsLinkPreview = true
    }
    
    func setupBinder(){
        youtubeVideoViewModel.movieVideo.bind{
            [weak self] video in
            guard let strongSelf = self,
                  let movieVideo = strongSelf.youtubeVideoViewModel.movieVideo.value else{return}
            if let url = URL.init(string: movieVideo.videoUrlStr ?? ""){
                strongSelf.webView2.load(URLRequest(url: url))}
   //         strongSelf.videoTitleLabel.text = movieVideo.videoName ?? ""
        }
    }
}
