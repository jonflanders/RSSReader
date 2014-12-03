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
	let itemPubDateName = "pubDate"
	let descriptionElementName = "description"
	let contentElementName = "content"
	let guidElementName = "guid"
	var feed:Feed?
	var channel:Channel?
	var temp:(String?,String?,String?,String?,NSDate)?
	var feedURL:String?
	var feedVersion:String?
	var feedParser: NSXMLParser?
	var callback:FeedCallback?
	var channelTitle:String?
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
			default:
				break
		}
	}
	func parser(parser: NSXMLParser!, didEndMappingPrefix prefix: String!) {
		
	}
	func parseRSSElement(attributes:[NSObject : AnyObject]!){
		
	}
	func setupTitleParse(){
		
	}
	func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
		switch elementName{
		case rssElementName:
			self.currentState = NSDataToFeedState.RSSElementState
		case channelElementName:
			self.currentState = NSDataToFeedState.ChannelElementState
		case itemElementName:
			self.currentState = NSDataToFeedState.ItemElementState
		case titleElementName:
			setupTitleParse()
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
		println("state is \(self.currentState.rawValue) - found string = \(string)")
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
		
	}
	func parserDidStartDocument(parser: NSXMLParser!) {
		if let cb = self.callback{
			if let f = self.feed{
				cb(f,nil)
			}else
			{
				cb(nil,NSError())
			}
		}
	}
	
}