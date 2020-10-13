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
    
    var video_VM:MovieVideos_VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL.init(string: video_VM?.videoUrlStr ?? ""){
            webView2.load(URLRequest(url: url))}
        videoTitleLabel.text = video_VM?.videoName ?? ""
        
        navBarView.backBttn.isHidden = false
        navBarView.backBttn.addTarget(self, action: Selector(("popVCFromNav")) , for: .touchUpInside)
        navBarView.titleLabel.isHidden = false
        navBarView.titleLabel.text = "Youtube"
        
        webView2.allowsLinkPreview = true
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
