//
//  FeedsDataSource.swift
//  RSSReader
//
//  Created by Jon Flanders on 12/5/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation
typealias JSONDictionary = Dictionary<String,AnyObject>?

struct FeedsDataSource{
	private func ensureFileExists()
	{
		let feedURL = self.getFeedPath()
		let fileManager = NSFileManager.defaultManager()
		if(!fileManager.fileExistsAtPath(feedURL.absoluteString!)){
			let feedTemplate = NSBundle.mainBundle().URLForResource(fileName, withExtension: extensionName)
			fileManager.copyItemAtURL(feedTemplate!, toURL:feedURL, error: nil)
		}

	}
	private func getFeedPath()->NSURL{
		let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
		let fn = "\(docPath)/\(fileName).\(extensionName)"
		let feedURL =  NSURL(fileURLWithPath: fn)!
		return feedURL

	}
	//var dictionary:NSDictionary?
	func getAllFeeds(callback:([String])->Void){
		self.ensureFileExists()
		var feeds = [String]()
		let feedURL = self.getFeedPath()
		let data = NSData(contentsOfURL: feedURL)
		let json =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as JSONDictionary
		if let dict = json {
			let allFeeds = dict[feedsKey] as [Dictionary<String,AnyObject>]
			for value in allFeeds{
				let urlValue = value[urlKey] as String
				feeds.append(urlValue)
			}
		}
		callback(feeds)
	}
	let extensionName = "json"
	let fileName = "Feeds"
	let feedsKey = "feeds"
	let urlKey = "url"
	func addAFeed(url:String){
		self.ensureFileExists()
		let feedURL = self.getFeedPath()
		let data = NSData(contentsOfURL: feedURL)
		var json =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as JSONDictionary
		if let dict = json {
			var allFeeds = dict[feedsKey] as [Dictionary<String,AnyObject>]
			var newFeed = Dictionary<String,AnyObject>()
			newFeed[urlKey] = url
			allFeeds.append(newFeed)
			json![feedsKey] = allFeeds
			self.saveFeedFile(json)
		}
	}
	private func saveFeedFile(json:JSONDictionary)
	{
		let feedURL = self.getFeedPath()
		let data = NSJSONSerialization.dataWithJSONObject(json!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
		data!.writeToURL(feedURL, atomically: false)
	}
	func removeAFeed(url:String){
		self.ensureFileExists()
		
	}
}