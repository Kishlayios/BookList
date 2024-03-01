//
//  BookListTests.swift
//  BookListTests
//
//  Created by Kishlay Kishore on 29/02/24.
//

import XCTest
@testable import BookList

final class BookListTests: XCTestCase {
    
    var homeModel: HomeListViewModel!
    private var webService: MockWebService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        homeModel = HomeListViewModel()
        webService = MockWebService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeModel = nil
    }

    func test_FetchAuthorData_ReturnFailure() {
        //Arrange
        homeModel.pageCount = 1
        homeModel.getTheAuthorList()
        let expectation = self.expectation(description: "Fetch Author List Web Service Success Expectation")
        
        // Act
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
        
        //Assert
        XCTAssertFalse(webService.authorListFetchSuccess)
    }
    

}

private class MockWebService: HomeListVMTrigger {
    
    var authorListFetchSuccess = false
    
    func reloadOnDataReceive() {
        authorListFetchSuccess = true
    }
}
