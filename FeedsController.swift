//
//  FeedsController.swift
//  RSSReader
//
//  Created by Jon Flanders on 12/5/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation


struct FeedsController{
	func getAllFeeds(callback:(Feeds)->Void){
		let ds = FeedsDataSource()
		ds.getAllFeeds { (feeds) -> Void in
			var newFeeds = Feeds()
			for (u,t) in feeds{
				var feed = Feed()
				feed.feedURL = u
				feed.feedTitle = t
				newFeeds.append(feed)
				//TODO: get data now or later?
			}
			callback(newFeeds)
			
		}
	}
	func addFeed(url:String ,callback:(Feed)->Void){

	}
	func removeFeed(url:String ,callback:(Bool)->Void){
		
	}
}