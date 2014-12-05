//
//  FeedsDataSourceTest.swift
//  RSSReader
//
//  Created by Jon Flanders on 12/5/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit
import XCTest

class FeedsDataSourceTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	func testNewFeed(){
		let expectation = self.expectationWithDescription("Test Adding new Feed")
		let ds = FeedsDataSource()
		let url = "http://www.jonflanders.com/?feed=rss2"
		ds.addAFeed(url)
		self.waitForExpectationsWithTimeout(10, handler: { (e) -> Void in
			
		})
	}
	func testDataSourceSimple(){
		let expectation = self.expectationWithDescription("Test Feed DataSource")
		
		let ds = FeedsDataSource()
		ds.getAllFeeds { (f) -> Void in
			expectation.fulfill()
			XCTAssertNotNil(f, "Feeds shouldn't be nil")
		}
		self.waitForExpectationsWithTimeout(10, handler: { (e) -> Void in
			
		})
	}
}