//
//  Feed.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation

typealias Feeds = [Feed]

let emptyString = ""
struct Feed {
	init(){
		self.feedChannel = Channel()
		self.feedURL = emptyString
		self.feedVersion = emptyString
		self.feedTitle = emptyString
	}
	var feedURL:String
	var feedVersion:String
	var feedChannel:Channel
	var feedTitle:String
}
struct FeedImage {
	init(){
		self.url = emptyString
	}
	var url:String
}
struct Channel {
	init(){
		self.channelDescription = emptyString
		self.channelTitle = emptyString
		self.channelURL = emptyString
		self.channelItems = [FeedItem]()
		self.channelLastUpdated = NSDate()
		self.channelImage = FeedImage()
	}
	var channelTitle:String
	var channelDescription:String
	var channelURL:String
	var channelLastUpdated:NSDate
	var channelItems:[FeedItem]
	var channelImage:FeedImage
	
}

struct FeedItem{
	init(){
		self.feedItemContent = emptyString
		self.feedItemDescription = emptyString
		self.feedItemLastUpdated = NSDate()
		self.feedItemTitle = emptyString
		self.feedItemURL = emptyString
	}
	var feedItemTitle:String
	var feedItemDescription:String
	var feedItemURL:String
	var feedItemContent:String
	var feedItemLastUpdated:NSDate
	
}