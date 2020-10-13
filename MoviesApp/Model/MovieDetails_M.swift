//
//  MovieDetails_M.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/11/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

struct MovieDetails_M:Decodable{
    
    var adult:Bool!
    var backdrop_path:String!
    var belongs_to_collection:BToCollection!
    var budget:Int!
    var genres:[Genres]!
    var homepage:String!
    var id:Int!
    var imdb_id:String!
    var original_language:String!
    var original_title:String!
    var overview:String!
    var popularity:Float!
    var poster_path:String!
    var production_companies:[ProductionCompany]!
    var production_countries:[ProductionCountries]!
    var release_date:String!
    var revenue:Int!
    var runtime:Int!
    var spoken_languages:[SpokenLanguages]!
    var status:String!
    var tagline:String!
    var title:String!
    var video:Bool!
    var vote_average:Float!
    var vote_count:Int!
}

struct BToCollection:Decodable{
    
    var id:Int!
    var name:String!
    var poster_path:String!
    var backdrop_path:String!
}

struct Genres:Decodable{

    var id:Int!
    var name:String!
}

struct ProductionCompany:Decodable{
    var id:Int!
    var logo_path:String!
    var name:String!
    var origin_country:String!
}

struct ProductionCountries:Decodable{

    var iso_3166_1:String!
    var name:String!
}

struct SpokenLanguages:Decodable{
    
    var iso_639_1:String!
    var name:String!
}


