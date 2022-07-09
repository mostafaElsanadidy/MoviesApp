//
//  VideoYoutubeLinkVC.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import UIKit
import WebKit

class VideoYoutubeLinkVC: UIViewController {

    @IBOutlet weak var navBarView: NavBarView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var webView2: WKWebView!
    
    private let viewModel = YoutubeVideoViewModel()
    
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
        viewModel.movieVideo.bind{
            [weak self] video in
            guard let strongSelf = self,
                  let movieVideo = strongSelf.viewModel.movieVideo.value else{return}
            if let url = URL.init(string: movieVideo.videoUrlStr ?? ""){
                strongSelf.webView2.load(URLRequest(url: url))}
            strongSelf.videoTitleLabel.text = movieVideo.videoName ?? ""
        }
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
