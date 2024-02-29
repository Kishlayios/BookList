//
//  HomeListViewModel.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import Foundation

protocol HomeListVMTrigger: AnyObject {
    func reloadOnDataReceive()
}

class HomeListViewModel: NSObject {
   
    // MARK: - Variables
    weak var delegate: HomeListVMTrigger?
    private let webService = HomeRepository()
    var pageCount = 1
    var arrAuthorList = [AuthorDataModel]()
    var arrFilteredAuthorList = [AuthorDataModel]()
    
    // MARK: - Helper Methods
    func callInitialApis() {
        self.getTheAuthorList()
    }
}

// MARK: - Get The Author List From Server
extension HomeListViewModel {
    
    func getTheAuthorList(isfromRefresh: Bool = false) {
        webService.getTheBookListFromServer(pageNo: self.pageCount) { result in
            if result?.response != nil {
                do {
                    let decodedData = try JSONDecoder().decode([AuthorDataModel].self, from: (result?.response)!)
                    self.arrAuthorList.append(contentsOf: decodedData)
                    self.delegate?.reloadOnDataReceive()
                } catch let err {
                    debugPrint("Err", err)
                }
            } else {
                ServiceManager.shared.executeFailureBlock()
            }
        }
    }
}
