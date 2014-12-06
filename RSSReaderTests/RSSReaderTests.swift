//
//  RSSReaderTests.swift
//  RSSReaderTests
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit
import XCTest

class RSSReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFeedController() {
		let modelController = ChannelController()
		let expectation = self.expectationWithDescription("Test Feed Controller")
		let url = "http://www.jonflanders.com/?feed=rss2"
		modelController.fillFeed(url, callback: { model , e -> Void in
			if let m = model{
				
			}else
			{
				XCTAssert(e != nil, "Error shouldn't be nil if feed is nil")
				XCTAssert(model != nil, "Feed model is nil")
				
			}
			expectation.fulfill()
		})
        // This is an example of a functional test case.
      self.waitForExpectationsWithTimeout(10, handler: { (err) -> Void in
		if let e = err{
			XCTAssert(false, "Feed handler failed")
		}
	})
    }
    
	
    
}
