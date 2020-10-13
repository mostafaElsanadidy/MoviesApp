//
//  Movie_M.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/11/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

struct Movie_M:Decodable{
    
    var popularity:Float!
    var vote_count:Int!
    var video:Bool!
    var poster_path:String!
    var id:Int!
    var adult:Bool!
    var backdrop_path:String!
    var original_language:String!
    var original_title:String!
    var genre_ids:[Int]!
    var title:String!
    var vote_average:Float!
    var overview:String!
    var release_date:String!
}
