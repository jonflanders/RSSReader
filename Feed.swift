//
//  Feed.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation


struct Feed {
	let feedURL:String
	let feedVersion:String
	let feedChannel:Channel
}

struct Channel {
	let channelTitle:String
	let channelDescription:String
	let channelURL:String
	let channelLastUpdated:NSDate
	let channelItems:[FeedItem]
	
}

struct FeedItem{
	let feedItemTitle:String
	let feedItemDescription:String
	let feedItemURL:String
	let feedItemContent:String
	let feedItemLastUpdated:NSDate
	
}