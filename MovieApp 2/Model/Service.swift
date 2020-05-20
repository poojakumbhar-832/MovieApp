//
//  service.swift
//  AlomfireTest
//
//  Created by Pooja kumbhar on 19/05/20.
//  Copyright © 2020 Pooja kumbhar. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    fileprivate var baseUrl = ""

    typealias moviesCallBack =  (_ movies:Movies?,_ status:Bool, _ message: String) -> Void
    var callback: moviesCallBack?
    
    init(baseUrl:String){
        self.baseUrl = baseUrl
    }
    
    func getCountryNameFrom(){
        AF.request(self.baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response{
            (responseData) in

            guard let data = responseData.data else {
                self.callback?(nil,false,"")
                return
                
            }
            do{
                let movies:Any = try  JSONDecoder().decode(Movies.self , from: data)
                self.callback?((movies as! Movies),true,"")
            }catch{
                self.callback?(nil,false,error.localizedDescription)
            }
        }
    }
    
    func completionHandler(callback: @escaping moviesCallBack){
        self.callback = callback
    }
    
}
