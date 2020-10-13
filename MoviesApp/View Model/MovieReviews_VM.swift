//
//  MovieReviews_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

class MovieReviews_VM{
   
    private var MovieReviews_M:MovieReviews_M?
    
    public var author:String!
    public var content:String!
    public var id:String!
    public var url:String!
    
    
    init(movieReviews_M:MovieReviews_M) {
        
        configureSubViews(with: movieReviews_M)
    }
    
    func configureSubViews(with movieReviews:MovieReviews_M){
        
        author = movieReviews.author!
        content = movieReviews.content!
        id = movieReviews.id!
        url = movieReviews.url!
        
    }
}
