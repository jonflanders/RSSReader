//
//  DetailViewController.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource {

	
	//Mark -  UITableViewDataSource
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let feed = self.detailItem{
			return feed.feedChannel.channelItems.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		 let cell =  UITableViewCell()
		if let realFeed = self.detailItem{
			let item = realFeed.feedChannel.channelItems[indexPath.row]
			cell.textLabel!.text = item.feedItemTitle
		}
		return cell
	}
	var detailItem: Feed? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}

	func configureView() {
		// Update the user interface for the detail item.
		if let feed = self.detailItem{
			let modelController = ChannelController()
			modelController.fillFeed(feed.feedURL, callback: { [unowned self] (newFeed, e) -> Void in
				self.detailItem = newFeed
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					if let tv = self.tableView{
						tv.reloadData()
					}
				})
			})
		}
	}
	
	@IBOutlet var tableView:UITableView?
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

