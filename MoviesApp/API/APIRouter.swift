//
//  APIRouter.swift
//  MadeInKuwait
//
//  Created by Amir on 1/29/20.
//  Copyright © 2020 Amir. All rights reserved.
//


import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case top_ratedMovies(apiKey:String)
    case popularMovies(apiKey:String)
    case upcomingMovies(apiKey:String)
    case now_playingMovies(apiKey:String)
    case getMovieDetails(movieID:Int,apiKey:String)
    case getMovieRecommendations(movieID:Int,apiKey:String)
    case getMovieCasts(movieID:Int,apiKey:String)
    case getMovieReviews(movieID:Int,apiKey:String)
    case getMovieVideos(movieID:Int,apiKey:String)
    case searchMovies(query:String,apiKey:String)
//    /movie?api_key=18f1dd9d9a6779af535c45513bd22779&query=The%20Avengers
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
//            el vend details fel post man get request w hena maktop .post ?
        case .top_ratedMovies , .popularMovies , .upcomingMovies , .now_playingMovies , .getMovieDetails, .getMovieRecommendations , .getMovieCasts , .getMovieVideos , .getMovieReviews , .searchMovies:
            return .get
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .top_ratedMovies(let api_key): return "/movie/top_rated?api_key=\(api_key)"
        case .popularMovies(let api_key): return "/movie/popular?api_key=\(api_key)"
        case .upcomingMovies(let api_key): return "/movie/upcoming?api_key=\(api_key)"
        case .now_playingMovies(let api_key): return "/movie/now_playing?api_key=\(api_key)"
        case .getMovieDetails(let movieID, let apiKey): return
            "/movie/\(movieID)?api_key=\(apiKey)"
        case .getMovieRecommendations(let movieID, let apiKey): return
            "/movie/\(movieID)/recommendations?api_key=\(apiKey)"
        case .getMovieCasts(let movieID, let apiKey) : return
        "/movie/\(movieID)/casts?api_key=\(apiKey)"
        case .getMovieReviews(let movieID, let apiKey): return
        "/movie/\(movieID)/reviews?api_key=\(apiKey)"
        case .getMovieVideos(let movieID, let apiKey): return
        "/movie/\(movieID)/videos?api_key=\(apiKey)"
        case .searchMovies(let query, let apiKey):
            return "/search/movie?api_key=\(apiKey)&query=\(query)"
        }
    }
    
    // MARK: - Parameters
//    why get api calls has no parameters and directly inserted within the url or if path == ta7t
    private var parameters: Parameters? {
        switch self {
            
//        case.login(let username,let password):
//            let parameters: [String:Any] = [
//            "password" : password ,
//            "username" : username
//            ]
//            return parameters
            
        case   .top_ratedMovies ,.popularMovies ,.upcomingMovies ,.now_playingMovies ,.getMovieDetails ,.getMovieRecommendations ,.getMovieReviews ,.getMovieCasts ,.getMovieVideos ,.searchMovies :
            return nil
       
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var main_api_url = ""
        main_api_url = Constants.ProductionServer.baseURL + path
        let urlComponents = URLComponents(string: main_api_url)!
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        
        print("URLS REQUEST :\(urlRequest)")
        
        // HTTP Method
//        urlRequest.httpMethod = method.rawValue
//        let credentialData = "ck_37baea2e07c8960059930bf348d286c7e48eb325:cs_0d74440eb12ac4726080563a4ceb0363ad5a0112".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//        let base64Credentials = credentialData.base64EncodedString()
//        let headers = "Basic \(base64Credentials)"
//
//        urlRequest.setValue(headers, forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print(parameters)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])

            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }


        }
        


//        if path == "login.php" || path == "edit_profile.php" || path == "edit_avatar.php" || path == "insertorder.php" || path == "add_customer_adrs.php" || path == "insert_order_cart.php"{
//            return try URLEncoding.default.encode(urlRequest, with: parameters)
//        }
        

        
        return urlRequest as URLRequest
        

    }
}
