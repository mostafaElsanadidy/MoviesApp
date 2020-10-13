//
//  Video_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

class MovieVideos_VM{
   
    private var movieVideos_M:MovieVideo_M?
    
    public var videoUrlStr:String?
    public var videoImagUrlStr:String?
    public var videoName:String?
    
    
    init(movieVideos_M:MovieVideo_M) {
        
        configureSubViews(with: movieVideos_M)
    }
    
    func configureSubViews(with videoDetails:MovieVideo_M){
        
        videoName = videoDetails.name!
        videoUrlStr = "https://www.youtube.com/watch?v=\(videoDetails.key ?? "")"
        videoImagUrlStr = "https://img.youtube.com/vi/\(videoDetails.key ?? "")/0.jpg"
    }
}
