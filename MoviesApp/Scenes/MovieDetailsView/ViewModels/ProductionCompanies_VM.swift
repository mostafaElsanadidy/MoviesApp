//
//  ProductionCompanies_VM.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 06.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation

class ProductionCompany_VM{
   
    private var productionCompany:ProductionCompany?
    
    public var id:Int?
    public var logo_path:String?
    public var name:String?
    public var origin_country:String?
    
    init(productionCompany:ProductionCompany) {
        
        configureSubViews(with: productionCompany)
    }
    
    func configureSubViews(with productionCompany:ProductionCompany){
        
        id = productionCompany.id!
        logo_path = "http://image.tmdb.org/t/p/w185\(productionCompany.logo_path ?? "")"
        name = productionCompany.name!
        origin_country = productionCompany.origin_country!
    }
}

