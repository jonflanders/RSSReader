//
//  NSDataToFeed.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation

class NSDataToFeed : NSObject, NSXMLParserDelegate{
	enum NSDataToFeedState : String {
		case RSSElementState  =  "RSS"
		case ChannelElementState = "Channel"
 		case ItemElementState = "Item"
	}
	var currentState:NSDataToFeedState = .RSSElementState
	let rssElementName = "rss"
	let channelElementName = "channel"
	let titleElementName = "title"
	let itemElementName = "item"
	let imageElementName = "image"
	let imageURLElementName = "url"
	let itemPubDateName = "pubDate"
	let descriptionElementName = "description"
	let contentElementName = "content"
	let guidElementName = "guid"
	var tempString = ""
	var feed:Feed?
	var channel:Channel?
	var feedURL:String?
	var feedVersion:String?
	var feedParser: NSXMLParser?
	var callback:FeedCallback?
	var curremItem:FeedItem?
	func deserialize(data:NSData, callback:FeedCallback){
		self.callback = callback
		self.feedParser = NSXMLParser(data: data)
		if let feedParser = self.feedParser{
			feedParser.delegate = self
			feedParser.parse()
		}
	}
	func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
		switch elementName{
			case rssElementName:
				break
			case channelElementName:
				break
			case itemElementName:
				self.channel!.channelItems.append(self.curremItem!)
			case titleElementName:
				self.titleEnd()
			case descriptionElementName:
				self.descriptionEnd()
			case itemPubDateName:
				self.itemPubDateEnd()
		case imageURLElementName:
			self.processImageURL();
			default:
				break
		}
	}
	func processImageURL(){
		var feedImage = FeedImage()
		feedImage.url = self.tempString
		self.channel!.channelImage = feedImage
	}
	let dateFormatter = { (Void)->NSDateFormatter in
		var ret = NSDateFormatter()
		ret.dateFormat =  "EEE, dd LLL yyyy kk:mm:ss +SSSS"
		return ret
	}()
	func dateFromString(string:String)->NSDate?{
		return self.dateFormatter.dateFromString(string)
	}
	func itemPubDateEnd(){
		switch self.currentState{
			case .RSSElementState:
				break
			case .ChannelElementState:
				break
			case .ItemElementState:
               if let item = curremItem {
					if let d = self.dateFromString(self.tempString)
					{
						self.curremItem!.feedItemLastUpdated  = d
					}
				}
		}
	}
	func contentEnd(){
		switch self.currentState{
			case .RSSElementState:
				break
			case .ChannelElementState:
				break
			case .ItemElementState:
				self.curremItem!.feedItemContent = self.tempString
		}
	}
	func descriptionEnd(){
		switch self.currentState{
			case .RSSElementState:
				break
			case .ChannelElementState:
				self.channel!.channelDescription  = self.tempString
			case .ItemElementState:
				self.curremItem!.feedItemDescription = self.tempString
		}
	}
	func titleEnd()
	{
		switch self.currentState{
			case .RSSElementState:
				break;
			case .ChannelElementState:
				self.channel!.channelTitle = self.tempString
			case .ItemElementState:
				self.curremItem!.feedItemTitle = self.tempString
			
		}
	}
	func parser(parser: NSXMLParser!, didEndMappingPrefix prefix: String!) {
		
	}
	
	func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
		self.tempString = ""
		switch elementName{
			case rssElementName:
				self.currentState = NSDataToFeedState.RSSElementState
				self.feed = Feed()
			case channelElementName:
				self.currentState = NSDataToFeedState.ChannelElementState
				self.channel = Channel()
			
			case itemElementName:
				self.currentState = NSDataToFeedState.ItemElementState
				self.curremItem = FeedItem()
			
			
			default:
				break
		}
	}
	func parser(parser: NSXMLParser!, didStartMappingPrefix prefix: String!, toURI namespaceURI: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundAttributeDeclarationWithName attributeName: String!, forElement elementName: String!, type: String!, defaultValue: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundCDATA CDATABlock: NSData!) {
		
	}
	func parser(parser: NSXMLParser!, foundCharacters string: String!) {
		self.tempString += string
	}
	func parser(parser: NSXMLParser!, foundComment comment: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundElementDeclarationWithName elementName: String!, model: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundExternalEntityDeclarationWithName name: String!, publicID: String!, systemID: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundIgnorableWhitespace whitespaceString: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundInternalEntityDeclarationWithName name: String!, value: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundNotationDeclarationWithName name: String!, publicID: String!, systemID: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundProcessingInstructionWithTarget target: String!, data: String!) {
		
	}
	func parser(parser: NSXMLParser!, foundUnparsedEntityDeclarationWithName name: String!, publicID: String!, systemID: String!, notationName: String!) {
		
	}
	func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
		
	}
	func parser(parser: NSXMLParser!, resolveExternalEntityName name: String!, systemID: String!) -> NSData! {
			return NSData()
	}
	func parser(parser: NSXMLParser!, validationErrorOccurred validationError: NSError!) {
		
	}
	func parserDidEndDocument(parser: NSXMLParser!) {
		if let cb = self.callback{
			if let f = self.feed{
				if let c = self.channel{
					self.feed!.feedChannel = c
					cb(self.feed!,nil)
				}
			}else
			{
				cb(nil,NSError())
			}
		}
	}
	func parserDidStartDocument(parser: NSXMLParser!) {
		
	}
	
}








