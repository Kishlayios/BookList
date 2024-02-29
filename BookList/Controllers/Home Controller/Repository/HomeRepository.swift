//
//  HomeRepository.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import Foundation

protocol HomeBookListDelegates {
    func getTheBookListFromServer(pageNo:Int,completionHandler: @escaping(_ result: ResponseData?)->())
}

class HomeRepository: HomeBookListDelegates {
    
    func getTheBookListFromServer(pageNo:Int,completionHandler: @escaping (ResponseData?) -> ()) {
        let url = "v2/list"
        var queryParam = [String:String]()
        queryParam["page"] = "\(pageNo)"
        queryParam["limit"] = "\(100)"
        
        ServiceManager.shared.callGetService(urlStr: url,queryParams: queryParam) { response in
            completionHandler(ResponseData(error: nil, response: response))
        } onFailure: { error in
            completionHandler(ResponseData(error: error, response: nil))
            print("Failure Response",error.localizedDescription)
        }

    }
    
}
