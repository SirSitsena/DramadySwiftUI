//
//  DramadyTests.swift
//  DramadyTests
//
//  Created by User on 22.11.2021.
//

import XCTest
@testable import Dramady

class DramadyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTabicon() throws {
        
        //Test that all tab names return a something on both lower and uppercase.
        let conf = Configuration()
        XCTAssert(conf.tabIcon(name: "main") != "")
        XCTAssert(conf.tabIcon(name: "Main") != "")
        
        XCTAssert(conf.tabIcon(name: "trending") != "")
        XCTAssert(conf.tabIcon(name: "Trending") != "")
        
        XCTAssert(conf.tabIcon(name: "Popular") != "")
        XCTAssert(conf.tabIcon(name: "popular") != "")
        
        XCTAssert(conf.tabIcon(name: "Favourites") != "")
        XCTAssert(conf.tabIcon(name: "favourites") != "")
        
        XCTAssert(conf.tabIcon(name: "Watchlist") != "")
        XCTAssert(conf.tabIcon(name: "watchlist") != "")
    }
    
    func testValidText() throws {
        let conf = Configuration()
        XCTAssert(conf.checkValidText(value: "") == "N/A")
        XCTAssert(conf.checkValidText(value: "myTest") == "myTest")
        XCTAssert(conf.checkValidText(value: String()) == "N/A")
        XCTAssert(conf.checkValidText(value: nil) == "N/A")
    }
    
    func testSearchTextValidation() throws {
        let conf = Configuration()
        XCTAssert(conf.inputEmptyCheck(searchText: ""))
        XCTAssert(conf.inputEmptyCheck(searchText: "    "))
        XCTAssertFalse(conf.inputEmptyCheck(searchText: "searchText2"))
        XCTAssertFalse(conf.inputEmptyCheck(searchText: "   searchText3   "))
    }

    func testWatchListStatus() throws {
        let conf = Configuration()
        XCTAssertTrue(conf.watchListStatus(isOnWatchList: true) == "clock.fill")
        XCTAssertTrue(conf.watchListStatus(isOnWatchList: false) == "clock")
    }
    
    func testFavListStatus() throws {
        let conf = Configuration()
        XCTAssertTrue(conf.favListStatus(isOnFavList: true) == "heart.fill")
        XCTAssertTrue(conf.favListStatus(isOnFavList: false) == "heart")
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
