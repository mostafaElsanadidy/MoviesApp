//
//  APIRouter.swift
//  MadeInKuwait
//
//  Created by Amir on 1/29/20.
//  Copyright © 2020 Amir. All rights reserved.
//


import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case login(username:String,password:String)
    case register(username:String,password:String,name:String,phone:String)
    case vendor_list(vencat:String)
    case user_orders(userid:Int)
    case create_order(vendorID:Int , des:String , from_address:String , to_address:String , customerID:Int , image:String ,voice:String)
    case submitCartOrder(json:Parameters)
    case vendor_details(venid:Int)
    case editProfile(id:Int , name:String , email:String , phone:String)
    case edit_avatar(id:Int, avatar:String)
    case add_address(id:Int, title:String , address:String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
//            el vend details fel post man get request w hena maktop .post ?
        case .login , .create_order ,.vendor_details ,.register ,.editProfile ,.edit_avatar , .add_address , .submitCartOrder:
            return .post
        case .user_orders , .vendor_list:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login: return "login.php"
        case .register: return "insertcustomer.php"
        case .create_order: return "insertorder.php"
        case .user_orders(let userid): return "orders.php?userid=\(userid)"
        case .vendor_details(let venid): return "vendordetail.php?venid=\(venid)"
        case .vendor_list(let vencat) : return "vendors.php?vencat=\(vencat)"
        case .editProfile: return "edit_profile.php"
        case .edit_avatar: return "edit_avatar.php"
        case .add_address: return "add_customer_adrs.php"
        case .submitCartOrder: return "insert_order_cart.php"
        }
    }
    
    // MARK: - Parameters
//    why get api calls has no parameters and directly inserted within the url or if path == ta7t
    private var parameters: Parameters? {
        switch self {
            
        case.login(let username,let password):
            let parameters: [String:Any] = [
            "password" : password ,
            "username" : username
            ]
            return parameters
           
        case .register(let username , let password , let name ,let phone):
            let parameters: [String:Any] = [
            "password":password ,
            "username":username ,
            "name" : name ,
            "phone" : phone
            ]
            return parameters
            
        case .create_order(let vendorID,let des,let from_address,let to_address,let customerID, let image, let voice) :
            let parameters: [String:Any] = [
              "venid":vendorID ,
              "customerid" : customerID ,
              "order_descar" : des ,
              "pickup_adrs" : from_address ,
              "delivery_adrs" : to_address ,
              "cost": "" ,
              "delivery_fees" : "" ,
              "image" : image ,
              "voicenote" : voice
              ]
              return parameters
            
            case .editProfile(let id , let name , let email , let phone ):
                let parameters: [String:Any] = [
                "customer_id" : id ,
                "name" : name ,
                "email" : email ,
                "phone" : phone
                ]
                return parameters
            
            case .edit_avatar(let id, let avatar):
                let parameters: [String:Any] = [
                "customer_id" : id ,
                "avatar" : avatar
                ]
                return parameters
            
        case .add_address(let id , let title , let address):
            let parameters: [String:Any] = [
             "customer_id" : id ,
             "adrs_title" : title,
             "address" : address
             ]
             return parameters
            
        case .submitCartOrder(let json):
            return json
            
        case   .user_orders ,.vendor_details ,.vendor_list :
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
        urlRequest.httpMethod = method.rawValue
        let credentialData = "ck_37baea2e07c8960059930bf348d286c7e48eb325:cs_0d74440eb12ac4726080563a4ceb0363ad5a0112".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = "Basic \(base64Credentials)"
        
        urlRequest.setValue(headers, forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print(parameters)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])

            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }


        }
        


        if path == "login.php" || path == "edit_profile.php" || path == "edit_avatar.php" || path == "insertorder.php" || path == "add_customer_adrs.php" || path == "insert_order_cart.php"{
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        

        
        return urlRequest as URLRequest
        

    }
}
