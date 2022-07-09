//
//  CastUser_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 10/12/20.
//  Copyright © 2020 mostafa elsanadidy. All rights reserved.
//

import Foundation

class CastUser_VM{
   
    private var castUser:CastUser_M?
    
    public var character:String?
    public var name:String?
    public var profile_path:String?
    public var order:Int?
    public var cast_id:Int?
    
    init(castUser:CastUser_M) {
        
        configureSubViews(with: castUser)
    }
    
    func configureSubViews(with castUser:CastUser_M){
        
        character = castUser.character!
        profile_path = "http://image.tmdb.org/t/p/w185\(castUser.profile_path ?? "")"
        name = castUser.name!
        order = castUser.order!
        cast_id = castUser.cast_id!
        
    }
}

