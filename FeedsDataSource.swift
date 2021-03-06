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
	func getAllFeeds(callback:([(String,String)])->Void){
		self.ensureFileExists()
		var feeds = [(String,String)]()
		let feedURL = self.getFeedPath()
		let data = NSData(contentsOfURL: feedURL)
		let json =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as JSONDictionary
		if let dict = json {
			let allFeeds = dict[feedsKey] as [Dictionary<String,AnyObject>]
			for value in allFeeds{
				let urlValue = value[urlKey] as String
				let titleValue = value[titleKey] as String
				feeds.append((urlValue,titleValue))
			}
		}
		callback(feeds)
	}
	
	let extensionName = "json"
	let fileName = "Feeds"
	let feedsKey = "feeds"
	let urlKey = "url"
	let titleKey = "title"
	
	func addAFeed(url:String,title:String){
		self.ensureFileExists()
		let feedURL = self.getFeedPath()
		let data = NSData(contentsOfURL: feedURL)
		var json =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as JSONDictionary
		if let dict = json {
			var allFeeds = dict[feedsKey] as [Dictionary<String,AnyObject>]
			var newFeed = Dictionary<String,AnyObject>()
			newFeed[urlKey] = url
			newFeed[titleKey] = title
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
		let feedURL = self.getFeedPath()
		let data = NSData(contentsOfURL: feedURL)
		var json =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as JSONDictionary
		if let dict = json {
			var allFeeds = dict[feedsKey] as [Dictionary<String,AnyObject>]
			var index = -1
			for i in 0..<allFeeds.count{
				var value = allFeeds[i]
				let urlValue = value[urlKey] as String
				if urlValue == url{
					index = i
				}
			}
			
			if index > -1 {
				allFeeds.removeAtIndex(index)
				json![feedsKey] = allFeeds
				self.saveFeedFile(json)
			}
		}
	}
}