//
//  FeedController.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation
typealias FeedCallback  = (Feed?,NSError?)->Void


struct FeedController{
	
	func fillFeed(url:String, callback:FeedCallback){
		var connection = ServerConnectionManager()
		connection.get(url, callback: { (d, e) -> Void in
			if let realData = d {
				var serializer = NSDataToFeed()
				serializer.deserialize(realData, callback: { (feed, error)-> Void in
					callback(feed ,error)
				
				})
			}
		})
	}
	
}