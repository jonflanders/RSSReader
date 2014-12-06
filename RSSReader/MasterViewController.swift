//
//  MasterViewController.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

	func refreshFeeds()
	{
		let feedsController = FeedsController()
		feedsController.getAllFeeds { [unowned self] (feedsObj) -> Void in
			self.feeds = feedsObj
			self.tableView.reloadData()
		}
	}
	var detailViewController: DetailViewController? = nil
	var feeds:Feeds?


	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    self.clearsSelectionOnViewWillAppear = false
		    self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.refreshFeeds()
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationItem.leftBarButtonItem = self.editButtonItem()

		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		self.navigationItem.rightBarButtonItem = addButton
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func insertNewObject(sender: AnyObject) {
		let alert = UIAlertController(title: "New Feed", message: "Add a new feed url", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[unowned self] (act) -> Void in
			var newTitle:String?
			var newURL:String?
			if let fields = alert.textFields{
				for f in fields as [UITextField]{
					switch f.tag{
					case 0:
						newURL = f.text
					case 1:
						newTitle = f.text
					default:
						break;
					}
				}
				
			}
			if let realTitle = newTitle{
				if let realURL = newURL{
					let feedsController = FeedsController()
					feedsController.addFeed(realURL, title: realTitle, callback: { (f) -> Void in
						self.refreshFeeds()
					})
				}
			}
			
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
		alert.addTextFieldWithConfigurationHandler { (tf) -> Void in
			tf.placeholder = "URL"
			tf.tag = 0
		}
		alert.addTextFieldWithConfigurationHandler { (tf) -> Void in
			tf.placeholder = "Name"
			tf.tag = 1
		}
		self .presentViewController(alert, animated: false) { () -> Void in
			
		}
	}

	// MARK: - Segues

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow() {
				if let realFeeds = self.feeds {
		        let object = realFeeds[indexPath.row]
					let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
					controller.detailItem = object
					controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
					controller.navigationItem.leftItemsSupplementBackButton = true
				}
		    }
		}
	}

	// MARK: - Table View

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let realFeeds = self.feeds{
			return realFeeds.count
		}
		return 0
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

		let object = self.feeds![indexPath.row] as Feed
		cell.textLabel!.text = object.feedTitle
		return cell
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
		   let feedsController = FeedsController()
			if let realFeeds = self.feeds {
				let object = realFeeds[indexPath.row]
				feedsController.removeFeed(object.feedURL, callback: { [unowned self](deleted) -> Void in
					self.refreshFeeds()
				})
			}
			
		} 
	}


}

